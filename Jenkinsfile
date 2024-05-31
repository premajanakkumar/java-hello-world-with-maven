pipeline {
    agent {
        docker {
            image 'maven:3.9.3-eclipse-temurin-17'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    environment {
        DOCKER_IMAGE = "premajanakumar/java-tomcat-app:${env.BUILD_NUMBER}"
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
        stage('Copy Artifact to Host') {
            agent any
            steps {
                script {
                    // Get the container ID of the running Docker agent
                    def containerId = sh(script: "docker ps -qf 'ancestor=maven:3.9.3-eclipse-temurin-17'", returnStdout: true).trim()
                    echo $containerId
                    
                    // Copy the artifact from the Docker container to the Jenkins host
                    sh "docker cp ${containerId}:/var/lib/jenkins/workspace/Java-Maven-Container/target/*.jar ."
                    sh(if [$? == 0] then;echo "copied successfully" else echo "failed")
                        
                }
            }
        }
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: '*.jar', allowEmptyArchive: true
            }
        }
                
         stage('Build Docker Image') {
            steps {
                script {
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
