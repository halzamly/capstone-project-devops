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
	  sh 'echo "Test logging-in to aws account"'
          sh 'aws ec2 describe-instances --region eu-central-1'
          sh 'echo "Setup Kubernetes Cluster"'
          sh 'aws eks update-kubeconfig --name dev-capstone-udacity --region eu-central-1'
          sh 'echo "Deploying to Kubernetes"'
          sh "kubectl apply -f ./kubernetes/deployment.yml"
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
