pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "snakkaops/my-java-app:latest"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/snakka-ops/java-app.git'
      }
    }

    stage('Build') {
      steps {
        sh 'mvn clean package'  // Build Java app using Maven
      }
    }

    stage('Docker Build') {
      steps {
        sh '''#!/bin/bash
          echo "Setting up Docker env from Minikube..."
          eval $(minikube docker-env)
          docker build -t $DOCKER_IMAGE .
        '''
      }
    }

    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh '''#!/bin/bash
            echo "$PASS" | docker login -u "$USER" --password-stdin
            docker push $DOCKER_IMAGE
          '''
        }
      }
    }
  }

  post {
    always {
      echo "Cleaning up workspace..."
      deleteDir()
    }
    success {
      echo "Pipeline completed successfully!"
    }
    failure {
      echo "Pipeline failed. Check the logs above."
    }
  }
}
