pipeline {
  agent any
  stages {
    stage('Lint Dockerfile') {
      steps {
        sh 'hadolint Dockerfile'
      }
    }

    stage('Build App') {
      agent {
        docker { image 'maven:3.6.3-jdk-11' }
      }
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
          dockerImage = docker.build dockerPath
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
    environment {
      awsRegion = 'eu-central-1'
      dockerPath = 'halzamly/springbootdemo'
    }
  }