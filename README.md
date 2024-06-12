<img src="https://github.com/Harsh971/Tic-Tac-Toe-CICD/blob/main/architecture.png"></img>

# Deploying a TicTacToe Game with Docker and Jenkins on AWS EC2 Instance

The objective of this documentation is to guide in deploying a TicTacToe game using Docker, Jenkins, and AWS EC2 instances. 
The deployment includes cloning the game code from GitHub, creating a Docker image, pushing it to DockerHub, and configuring an AWS EC2 instance with an Application Load Balancer to host the game.

## Prerequisites:
1. Access to GitHub repository containing TicTacToe game code.
2. Access to DockerHub account.
3. An AWS account with permissions to create and manage EC2 instances and Application Load Balancers.
4. Jenkins installed and configured on an AWS EC2 instance.
5. Basic understanding of Docker, Jenkins, AWS EC2, and Application Load Balancer.

## Steps:

### 1. Clone TicTacToe Game Repository:
   - SSH into the AWS EC2 instance where Jenkins is installed.
   - Create a Jenkins pipeline job to clone the TicTacToe game repository from GitHub.
   - Configure Jenkins to trigger this job on code changes.

### 2. Build Docker Image:
   - Write a Dockerfile to define the environment and dependencies required to run the TicTacToe game.
   - Modify the Jenkins pipeline to build the Docker image using the Dockerfile.
   - Tag the Docker image with appropriate versioning.

## Dockerfile :
```sh
# Use an official Nginx image as a parent image
FROM nginx:latest

# Copy the local files into the container's filesystem
COPY . /usr/share/nginx/html

# Expose port 80 to allow outside access
EXPOSE 80

# Start Nginx with global binding to 0.0.0.0
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

```

   
### 3. Push Docker Image to DockerHub:
   - Configure Jenkins with DockerHub credentials.
   - Modify the Jenkins pipeline to push the Docker image to DockerHub after successful build.

## docker-compose.yaml :
```sh
version : "3.3"
services :
  web :
     image : harsh0369/tic-tac-toe-app:latest
     ports :
         - "80:80"
```

### 4. Set Up AWS EC2 Instance:
   - Launch an AWS EC2 instance with the desired specifications and security groups.
   - Install Docker on the EC2 instance.
   - SSH into the EC2 instance and pull the Docker image from DockerHub.

### 5. Configure Application Load Balancer:
   - Create an Application Load Balancer in AWS.
   - Set up target groups for the EC2 instances hosting the TicTacToe game.
   - Configure listener rules to route traffic based on URL postfix (/two for index2.html and default to index.html).

### 6. Deploy TicTacToe Game:
   - Update Jenkins pipeline to include deployment steps.
   - Configure Jenkins pipeline to SSH into the EC2 instance and run the Docker container with appropriate parameters.
   - Test the deployment by accessing the TicTacToe game through the Application Load Balancer URL.

## Jenkinsfile :
```sh
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
                sh 'docker pull harsh0369/tic-tac-toe-app:latest'
                echo "Deploying the container"
                sh "docker-compose down && docker-compose up -d"                
            }
        }
    }
}
```
<center>
<img src="https://github.com/Harsh971/Tic-Tac-Toe-CICD/blob/main/2.png"></img>

<img src="https://github.com/Harsh971/Tic-Tac-Toe-CICD/blob/main/3.png"></img>

<img src="https://github.com/Harsh971/Tic-Tac-Toe-CICD/blob/main/1.png"></img>
</center>

Game Code Reference : [Click Here](https://github.com/arasgungore/Tic-Tac-Toe)

## Feedback

Your feedback is valuable! If you have suggestions for improving existing content or ideas for new additions, please open an issue or reach out to the repository maintainers. If you have any other feedbacks, you can reach out to us at harsh.thakkar0369@gmail.com


## Connect with Me
<p>

 <a href="https://twitter.com/HarshThakkar971" target="blank"><img align="center" src="https://img.freepik.com/premium-vector/vector-new-twitter-x-white-logo-black-background_744381-866.jpg" alt="HarshThakkar971" height="40" width="50" /></a>
  &nbsp;&nbsp;
  	<a href="https://linkedin.com/in/harsh-thakkar-7764bb1a4" target="blank"><img align="center" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/LinkedIn_logo_initials.png/800px-LinkedIn_logo_initials.png" alt="harsh-thakkar-7764bb1a4" height="40" width="40" /></a>
  &nbsp;&nbsp;
 <a href="https://instagram.com/harsh_thakkar09" target="blank"><img align="center" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/768px-Instagram_logo_2016.svg.png" alt="harsh_thakkar09" height="40" width="40" /></a>
</p>

