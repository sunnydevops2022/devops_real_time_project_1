pipeline {
    agent any
    environment {
      PATH = "$PATH:/opt/apache-maven-3.9.1/bin"
    }
    
    stages {

        stage('CLEAN WORKSPACE') {
            steps {
                cleanWs()
            }
        }

        stage('CODE CHECKOUT') {
            steps {
                git 'https://github.com/sunnydevops2022/devops_real_time_project_1.git'
            }
        }
        
        stage('MODIFIED IMAGE TAG') {
            steps {
                sh '''
                   sed "s/image-name:latest/$JOB_NAME:v1.$BUILD_ID/g" playbooks/dep_svc.yml
                   sed -i "s/image-name:latest/$JOB_NAME:v1.$BUILD_ID/g" playbooks/dep_svc.yml
                   sed -i "s/IMAGE_NAME/$JOB_NAME:v1.$BUILD_ID/g" webapp/src/main/webapp/index.jsp
                   '''
            }            
        }
        
        stage('BUILD') {
            steps {
                sh 'mvn clean install package'
            }
        } 
        
        stage('SONAR SCANNER') {
            environment {
            sonar_token = credentials('SONAR_TOKEN')
            }
            steps {
                sh 'mvn sonar:sonar -Dsonar.projectName=$JOB_NAME \
                    -Dsonar.projectKey=$JOB_NAME \
                    -Dsonar.host.url=http://172.31.84.238:9000 \
                    -Dsonar.token=$sonar_token'
            }
        } 
        
        stage('COPY JAR & DOCKERFILE') {
            steps {
                sh 'ansible-playbook playbooks/create_directory.yml'
            }
        }
        
        stage('PUSH IMAGE ON DOCKERHUB') {
            environment {
            dockerhub_user = credentials('DOCKERHUB_USER')            
            dockerhub_pass = credentials('DOCKERHUB_PASS')
            }    
            steps {
                sh 'ansible-playbook playbooks/push_dockerhub.yml \
                    --extra-vars "JOB_NAME=$JOB_NAME" \
                    --extra-vars "BUILD_ID=$BUILD_ID" \
                    --extra-vars "dockerhub_user=$dockerhub_user" \
                    --extra-vars "dockerhub_pass=$dockerhub_pass"'              
            }
        }
        
        stage('DEPLOYMENT ON EKS') {
            steps {
                sh 'ansible-playbook playbooks/create_pod_on_eks.yml \
                    --extra-vars "JOB_NAME=$JOB_NAME"'
            }            
        }          

    }
}      
