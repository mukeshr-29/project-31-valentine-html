pipeline{
    agent any
    environment{
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages{
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/mukeshr-29/project-31-valentine-html.git'
            }
        }
        stage('trivy file scan'){
            steps{
                sh 'trivy fs --format table -o trivyfs-report.html .'
            }
        }
        stage('static code analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonarqube', installationName: 'sonar-server'){
                        sh '''
                            $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=valentine \
                            -Dsonar.projectName=valentine
                        '''
                    }
                }
            }
        }
        stage('quality check'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'
                }
            }
        }
        stage('docker build and tag'){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker'){
                        sh 'docker build -t valentinepro .'
                        sh 'docker tag valentinepro mukeshr29/valentinepro'
                    }
                }
            }
        }
        stage('trivy img scan'){
            steps{
                sh 'trivy image --format json -o trivyimg-report.json mukeshr29/valentinepro'
            }
        }
        stage('docker img push to hub'){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker'){
                        sh 'docker push mukeshr29/valentinepro'
                    }
                }
            }
        }
        stage('deploy to container'){
            steps{
                sh 'docker run -d -p 80:80 mukeshr29/valentinepro'
            }
        }
    }
    
}