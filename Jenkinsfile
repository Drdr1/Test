pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'appseed/flask-dr-dashboard'
    }

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t my-flask-app .'
                sh 'docker tag my-flask-app ${DOCKER_USERNAME}/${DOCKER_IMAGE}'
            }
        }

        stage('Test') {
            steps {
                sh 'source env/bin/activate'
                sh 'python -m unittest discover -s tests -p "test_*.py"'
            }
        }

        stage('Lint') {
            steps {
                sh 'source env/bin/activate'
                sh 'flake8 .'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'
                    sh 'docker tag ${DOCKER_IMAGE} ${DOCKER_USERNAME}/${DOCKER_IMAGE}'
                    sh 'docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE}'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Pipeline successful!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            sh 'docker logout'
        }
    }
}
