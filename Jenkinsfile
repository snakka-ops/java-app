pipeline {
    agent { label 'master' }

    tools {
        maven 'Maven 3.8.6'   // exact name from Jenkins config
        jdk 'Java 11'         // exact name from Jenkins config
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/snakka-ops/java-app.git', branch: 'master'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Publish Test Results') {
            steps {
                junit '**/target/surefire-reports/*.xml'
            }
        }
    }
}
