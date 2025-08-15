pipeline {
  agent {
    kubernetes {
      yaml """
      apiVersion: v1
      kind: Pod
      spec:
        containers:
        - name: maven-docker
          image: maven:3.8.7-openjdk-17
          command:
          - cat
          tty: true
          volumeMounts:
          - name: docker-socket
            mountPath: /var/run/docker.sock
        volumes:
        - name: docker-socket
          hostPath:
            path: /var/run/docker.sock
      """
      defaultContainer 'maven-docker'
    }
  }

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
        sh 'mvn clean package'
      }
    }

    stage('Docker Build') {
      steps {
        sh '''
          echo "Building Docker image"
          docker build -t $DOCKER_IMAGE .
        '''
      }
    }

    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh '''
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
