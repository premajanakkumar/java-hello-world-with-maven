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
        stage('Deploy to Tomcat') {
            steps {
                script {
                    // Stop and remove existing Tomcat container
                    sh 'docker stop tomcat || true && docker rm tomcat || true'

                    // Run new Tomcat container with the built WAR
                    sh 'docker run -d -p 8080:8080 --name tomcat -v $WORKSPACE/target/your-maven-project.war:/usr/local/tomcat/webapps/your-maven-project.war tomcat:9.0'
                }
            }
        }
    }
}
