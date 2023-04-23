pipeline {
    agent any
    environment {
      PATH = "$PATH:/opt/apache-maven-3.9.1/bin"
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/sunnydevops2022/devops_real_time_project_1.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install package'
            }
        }        
//         stage('Sonar Scaner') {
//             steps {
//                 sh 'mvn sonar:sonar -Dsonar.projectName="helloworld-project" \
//                 -Dsonar.projectKey=helloworld-project \
//                 -Dsonar.host.url=http://54.146.178.210:9000 \
//                 -Dsonar.login=$token'
//             }
//         } 
        
        stage('Copy Jar & Dockerfile') {
            steps {
                sh 'ansible-playbook create_directory.yml -u ubuntu'
            }
        }         
        
        stage('Push Dockerhub') {
            steps {
                sh 'ansible-playbook push_dockerhub.yml -u ubuntu --extra-vars "JOB_NAME=$JOB_NAME" --extra-vars "BUILD_ID=$BUILD_ID"'
            }
        }          
    }
}
