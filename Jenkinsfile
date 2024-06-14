pipeline {
    agent any

    environment {
        // Define environment variables
        DOCKER_IMAGE = 'wildfly-custom:latest'
        DEPLOY_DIR = '/opt/jboss/wildfly/standalone/deployments'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the project from GitHub
                git 'https://github.com/mosaad96/git_pro.git'
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
                // Build the Docker image
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Get the .jar file
                    def jarFile = findFiles(glob: '**/target/*.jar')[0]

                    // Deploy the .jar file to the WildFly container
                    docker.image(DOCKER_IMAGE).inside {
                        sh "cp ${jarFile} ${DEPLOY_DIR}/"
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                // Run the WildFly container
                script {
                    docker.run('-d -p 7070:7070 --name wildfly-app', DOCKER_IMAGE)
                }
            }
        }
    }

    post {
        always {
            // Cleanup the container after the pipeline
            script {
                try {
                    sh 'docker stop wildfly-app'
                    sh 'docker rm wildfly-app'
                } catch (Exception e) {
                    echo 'No container to clean up'
                }
            }
        }
    }
}

