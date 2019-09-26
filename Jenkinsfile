pipeline {
  agent any
  stages {
    stage('Build SQL') {
      parallel {
        stage('Build SQL') {
          steps {
            echo 'Building SQL...'
            sh 'docker build -f sql/Dockerfile -t asterisktech/sql:latest sql'
          }
        }
        stage('Build Hapi') {
          steps {
            echo 'Build Hapi...'
          }
        }
      }
    }
    stage('Test') {
      parallel {
        stage('Test') {
          steps {
            echo 'SonarScanner'
            sh 'docker run --rm -i -v $(pwd):/root/src asterisktech/sonarscanner  -Dsonar.host.url=http://217.66.102.142:8090'
          }
        }
        stage('Run sql') {
          steps {
            echo 'Run SQL Docker'
            sh 'docker run --rm asterisktech/sql:latest'
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying....'
      }
    }
    stage('Clean') {
      steps {
        echo 'Clean'
        sh 'sudo rm  -rf .scannerwork'
      }
    }
  }
}