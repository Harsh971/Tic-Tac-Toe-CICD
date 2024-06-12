pipeline {
    agent any 
    
    stages{
        stage("Clone Code"){
            steps {
                echo "Cloning the code"
                git url:"https://github.com/Harsh971/Tic-Tac-Toe-CICD.git", branch: "main"
		sh "cp index.html index2.html"
            }
        }
        stage("Build"){
            steps {
                echo "Building the image"
                sh "docker build -t tic-tac-toe-app ."
            }
        }
        stage("Push to Docker Hub"){
            steps {
                echo "Pushing the image to docker hub"
                withCredentials([usernamePassword(credentialsId:"DockerHub",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                sh "docker tag tic-tac-toe-app ${env.dockerHubUser}/tic-tac-toe-app:latest"
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker push ${env.dockerHubUser}/tic-tac-toe-app:latest"
                }
            }
        }
        stage("Deploy"){
            steps {
                echo "Deploying the container"
                sh "docker-compose down && docker-compose up -d"                
            }
        }
    }
}