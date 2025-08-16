pipeline {
    agent any

    tools {
        maven 'Maven 3.8.6'  // Use the Maven version configured in Jenkins
        jdk 'Java 11'        // Use the JDK installed in Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/snakka-ops/java-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Publish Test Results') {
            steps {
                junit '**/target/surefire-reports/*.xml'
            }
        }
    }
}
