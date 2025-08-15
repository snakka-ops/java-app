pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "snakkaops/my-java-app:latest"
  }
  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/snakka-ops/java-app.git', credentialsId: 'github-token'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Scan') {
      steps {
        echo 'Code scan placeholder (add SonarQube setup later)'
      }
    }
    stage('Docker Build') {
      steps {
        sh """
          eval \$(minikube docker-env)
          docker build -t $DOCKER_IMAGE .
        """
      }
    }
    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh """
            echo $PASS | docker login -u $USER --password-stdin
            docker push $DOCKER_IMAGE
          """
        }
      }
    }
  }
  post {
    always {
      cleanWs() // Make sure the Workspace Cleanup plugin is installed!
    }
  }
}
