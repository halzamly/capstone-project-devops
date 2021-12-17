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
        node {
          label 'maven:3.6.3-jdk-11'
        }

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
        sh 'dockerImage = docker.build dockerpath'
      }
    }

    stage('Push Image') {
      steps {
        sh '''docker.withRegistry( \'\', registryCredential ) {
dockerImage.push()
}'''
        }
      }

    }
    environment {
      awsRegion = 'eu-central-1'
      dockerpath = 'halzamly/springbootdemo'
    }
  }