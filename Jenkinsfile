pipeline {
  agent any
  stages {
    stage('Lint Dockerfile') {
      steps {
        sh 'hadolint Dockerfile'
      }
    }

    stage('Build App') {
      steps {
        sh 'mvn clean package -DskipTests=true'
        archiveArtifacts 'target/*.jar'
      }
    }

    stage('Test App') {
      steps {
        sh 'mvn test'
        junit(allowEmptyResults: true, testResults: 'target/surefire-reports/TEST-*.xml', skipPublishingChecks: true)
      }
    }

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build registry + ":latest"
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Deploy kubernetes'){
      steps{
        withAWS(region:'eu-central-1', credentials:'aws-credentials') {
	  sh 'echo "Create a kubeconfig for Amazon EKS"'
          sh 'aws eks --region eu-central-1 update-kubeconfig --name dev-capstone-udacity'
          sh 'echo "Deploying to Kubernetes"'
          sh 'kubectl apply -f ./kubernetes/deployment.yml'
          sh 'echo "Deployment result"'
          sh "kubectl get svc"
          sh "kubectl get nodes"
          sh "kubectl get deployment"
          sh "kubectl get pod -o wide"
          script{
            serviceAddress = sh(script: "kubectl get svc --output=json | jq -r '.items[0] | .status.loadBalancer.ingress[0].hostname'", returnStdout: true).trim()
          }
          sh "echo 'Deployment Complete!'"
          sh "echo 'Application endpoint: http://$serviceAddress'"
	    }
	  }
	}

  }

  environment {
    AWS_DEFAULT_REGION = 'eu-central-1'
    registry = 'halzamly/springbootdemo'
    registryCredential = 'dockerhub-credentials'
  }
}
