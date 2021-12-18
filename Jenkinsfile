pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION = 'eu-central-1'
    DOCKER_BATH = 'halzamly/springbootdemo'
  }

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
        junit(allowEmptyResults: true, testResults: 'target/surefire-reports/TEST-*.xml')
      }
    }

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build DOCKER_BATH
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
  }
}