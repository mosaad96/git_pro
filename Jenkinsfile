pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-wildfly-app'
        DOCKER_REGISTRY = 'my-docker-registry'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                git branch: 'main', url: 'https://github.com/mosaad96/git_pro.git'
            }
        }

        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Create a container from the image and copy the jar file to deployments
                    sh '''
                    docker create --name temp-container ${DOCKER_IMAGE}
                    docker cp target/your-project.jar temp-container:/opt/jboss/wildfly/standalone/deployments/
                    docker commit temp-container ${DOCKER_IMAGE}
                    docker rm temp-container
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Run the container
                    sh 'docker run -d --name wildfly-app -p 7070:8080 ${DOCKER_IMAGE}'
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images to save space
            sh 'docker image prune -f'
        }
    }
}

