pipeline {
  agent any

  stages {
    stage('Clone') {
      steps {
        git 'https://github.com/ElangCahyaMaulid/infra-automation-demo.git'
      }
    }

    stage('Deploy to Minikube') {
      steps {
        sh 'kubectl apply -f kubernetes/monitoring/'
      }
    }
  }
}
