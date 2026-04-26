pipeline {
    agent { label 'worker' }

    environment {
        IMAGE = "kuzmenkoserhii053/step-project2:latest"
    }

    stages {

        stage('Build Docker') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Run tests') {
            steps {
                sh 'docker run --rm $IMAGE test'
            }
        }

        stage('Push') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo $PASS | docker login -u $USER --password-stdin
                        docker push $IMAGE
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo "Tests failed"
        }
    }
}
