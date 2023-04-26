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
                   sed -i "s/APP_VERSION/v1.$BUILD_ID/g" webapp/src/main/webapp/index.jsp
                   '''
            }            
        } 
        
        stage('BUILD') {
            steps {
                sh 'mvn clean install package'
            }
        }        

//         stage('SONAR SCANNER') {
//             steps {
//                 sh 'mvn sonar:sonar -Dsonar.projectName="helloworld-project" \
//                 -Dsonar.projectKey=helloworld-project \
//                 -Dsonar.host.url=http://54.146.178.210:9000 \
//                 -Dsonar.login=$token'
//             }
//         } 
        
        stage('COPY JAR & DOCKERFILE') {
            steps {
                sh 'ansible-playbook playbooks/create_directory.yml'
            }
        }         
        
        stage('PUSH IMAGE ON DOCKERHUB') {
            steps {
                sh 'ansible-playbook playbooks/push_dockerhub.yml --extra-vars "JOB_NAME=$JOB_NAME" --extra-vars "BUILD_ID=$BUILD_ID"'
            }
        }          
        
//         stage('Deployment') {
//             steps {
//                 sh 'ansible-playbook playbooks/create_docker_container.yml --extra-vars "JOB_NAME=$JOB_NAME"'
//             }      
          
        stage('DEPLOYMENT ON EKS') {
            steps {
                sh 'ansible-playbook playbooks/create_pod_on_eks.yml'
            }            
        }          
    }
}
