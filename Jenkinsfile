
pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/mosaad96/git_pro.git'
        JDK_IMAGE = 'openjdk:11-jdk'
        DOCKER_IMAGE = 'myapp:latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "${env.REPO_URL}"
            }
        }

        stage('Build') {
            steps {
                script {
                    // Assuming Maven is used
                    sh 'mvn clean package'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${env.DOCKER_IMAGE} ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "docker run -d -p 7070:8080 ${env.DOCKER_IMAGE}"
                }
            }
        }
    }

     post {
        always {
            script {
                try {
                    cleanWs()
                } catch (Exception e) {
                    echo "Failed to clean workspace: ${e.getMessage()}"
                }
            }
        }
    }
}
