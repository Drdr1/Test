pipeline {
    agent any

    

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t argon-dashboard-flask .'
                sh 'docker tag argon-dashboard-flask ${DOCKER_USERNAME}/${DOCKER_IMAGE}'
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
                sh 'docker-compose up -d appseed_app'
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
