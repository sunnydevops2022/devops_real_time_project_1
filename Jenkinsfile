pipeline {
    agent any
    environment {
      PATH = "$PATH:/opt/apache-maven-3.9.1/bin"
    }
    
    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

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
                sh 'ansible-playbook playbooks/create_directory.yml'
            }
        }         
        
        stage('Push Image On Dockerhub') {
            steps {
                sh 'ansible-playbook playbooks/push_dockerhub.yml --extra-vars "JOB_NAME=$JOB_NAME" --extra-vars "BUILD_ID=$BUILD_ID"'
            }
        }          
        
//         stage('Deployment') {
//             steps {
//                 sh 'ansible-playbook playbooks/create_docker_container.yml --extra-vars "JOB_NAME=$JOB_NAME"'
//             }
        
        stage('Change Tag') {
            steps {
                sh '''
                   sed "s/image-name:latest/$JOB_NAME:v1.$BUILD_ID/g" playbooks/dep_svc.yml
                   sed -i "s/image-name:latest/$JOB_NAME:v1.$BUILD_ID/g" playbooks/dep_svc.yml
                   '''
            }            
        }         
            
        stage('EKS Deployment') {
            steps {
                sh 'ansible-playbook playbooks/create_pod_on_eks.yml'
            }            
        }          
    }
}
