pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="909263615116"
        AWS_DEFAULT_REGION="us-east-1"
    }

    stages {    
    
        stage('Log in AWS ECR') {
            steps {
                withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                    sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/flask-app'
                    sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/mysql-db'
                    echo 'log in AWS ECR successed'
                }

            }
        }

    

        stage('Build new docker image for FlaskApp'){
            steps {
                sh 'docker build -t ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/flask-app:latest   ./FlaskApp'
                echo 'Building FlaskApp image was done !'
            }
        }

        stage('Build new docker image for MySQL-database'){
            steps {
                sh 'docker build -t ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/mysql-db:latest ./MySQL_Queries'
                echo 'Building MySQL_Queries image was done !'
            }
        }

        stage('docker push Flask-app') {
            steps {
                withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                    sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/flask-app:latest'
                    echo 'Pushing FlaskApp image was done !'
                }
            }
        }

        stage('docker push MySQL-database') {
            steps {
                withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                    sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/mysql-db:latest'
                    echo 'Pushing MySQL_Queries image was done !'
                }
            }
        
        }
        stage(' Apply Kuberentes files') {
            steps {
                withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                    sh'kubectl apply -f kubernetes/mysql-pv.yaml  -f kubernetes/mysql-pvc.yaml -f kubernetes/mysql-configmap.yaml -f kubernetes/mysql-service.yaml -f kubernetes/mysql-deployment.yaml -f kubernetes/statefulset.yaml -f kubernetes/secrets.yaml'
                    sh'kubectl apply -f kubernetes/redis-deployment.yaml -f kubernetes/flask-python-service.yaml -f kubernetes/python-deployment.yaml'
                    sh'kubectl apply -f kubernetes/Ingress.yaml'
                }
            }
        }
    }
}
