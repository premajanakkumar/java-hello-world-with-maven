pipeline {
    agent {
        docker {
            image 'maven:3.9.3-eclipse-temurin-17'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/pranesh-1998/java-hello-world-with-maven'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
