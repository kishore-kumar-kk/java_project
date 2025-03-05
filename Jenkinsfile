pipeline {
    agent { label 'kishore' }
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = '120569634883.dkr.ecr.us-east-1.amazonaws.com/jenkins-build'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/kishore-kumar-kk/java_project.git'
            }
        }
        stage('Build Java Application') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "sudo docker build -t mynewimage ."  // Using 'mynewimage' as the image name
            }
        }
        stage('Push Image to AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | sudo docker login --username AWS --password-stdin ${ECR_REPO}"
                    sh "sudo docker tag mynewimage:latest ${ECR_REPO}:latest"  // Correct image name 'mynewimage'
                    sh "sudo docker push ${ECR_REPO}:latest"
                }
            }
        }
    }
}

