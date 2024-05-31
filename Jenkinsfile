pipeline {
    agent {
        docker {
            image 'maven:3.9.3-eclipse-temurin-17'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    environment {
        DOCKER_IMAGE = "your-dockerhub-username/java-tomcat-app:${env.BUILD_NUMBER}"
        REGISTRY_CREDENTIALS = credentials('docker-cred')
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
        agent any
        
        stage('Build Docker Image') {
            steps {
                script {
                    writeFile file: 'Dockerfile', text: '''
                    FROM tomcat:9.0
                    COPY target/*.war /usr/local/tomcat/webapps/
                    '''
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
