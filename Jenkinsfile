pipeline {
    agent { label 'master' }  // Run only on master node
    
    tools {
        // Replace 'Maven 3.x' and 'JDK 11' with your actual tool names configured in Jenkins
        maven 'Maven 3.x'   
        jdk 'JDK 11'
    }

    stages {
        stage('Checkout') {
            steps {
                // Git checkout (no credentials in this example)
                git url: 'https://github.com/snakka-ops/java-app.git', branch: 'master'
            }
        }

        stage('Build') {
            steps {
                // Run Maven build; Jenkins will set JAVA_HOME and PATH automatically based on tools{} block
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
