pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "snakkaops/my-java-app:latest"
  }
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/snakka-ops/java-app.git'  // Public repo, no creds needed
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'  // Build Java app using Maven
      }
    }
    stage('Docker Build') {
      steps {
        sh '''
          eval $(minikube docker-env)
          docker build -t $DOCKER_IMAGE .
        '''
      }
    }
    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh '''
            echo $PASS | docker login -u $USER --password-stdin
            docker push $DOCKER_IMAGE
          '''
        }
      }
    }
  }
  post {
    always {
      deleteDir()  // Clean workspace (built-in, no plugin needed)
    }
  }
}
