pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Docker Build') {
            steps {
                sh "docker build . -t gopichandmiryala/hiringapp:$BUILD_NUMBER"
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub', variable: 'hubPwd')]) {
                    sh "docker login -u gopichandmiryala -p ${hubPwd}"
                    sh "docker push gopichandmiryala/hiringapp:$BUILD_NUMBER"
                }
            }
        }

        stage('Checkout K8S manifest SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/gopichandmiryala/Hiring-app-argocd.git'
            }
        }

        stage('Update K8S manifest & push to Repo') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'github-pat', variable: 'GIT_PAT')]) {
                        sh '''
                        cat /var/lib/jenkins/workspace/$JOB_NAME/dev/deployment.yaml
                        sed -i "s/5/${BUILD_NUMBER}/g" /var/lib/jenkins/workspace/$JOB_NAME/dev/deployment.yaml
                        cat /var/lib/jenkins/workspace/$JOB_NAME/dev/deployment.yaml

                        git config user.email "jenkins@example.com"
                        git config user.name "Jenkins CI"

                        git add .
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline' || echo "No changes to commit"
                        git remote set-url origin https://$GIT_PAT@github.com/gopichandmiryala/Hiring-app-argocd.git
                        git push origin main
                        '''
                    }
                }
            }
        }
    }
}
