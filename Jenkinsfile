// pipeline {
//     agent {
//         docker {
//             image 'node:18-alpine'
//             label 'docker-agent-node'
//         }
//     }
//     triggers {
//         githubPush()
//     }
//     stages {
//         stage('Install Dependencies') {
//             steps {
//                 echo 'Installing Dependencies'
//                 sh 'npm install'
//             }
//         }
//         stage('Build') {
//             steps {
//                 echo 'Building...'
//                 sh 'npm run build'
//             }
//         }
//         stage('Test') {
//             steps {
//                 echo 'Testing...'
//                 sh 'npm test -- --watchAll=false'
//             }
//         }
//         stage('Deploy') {
//             steps {
//                 echo 'Deploying...'
//                 sh 'npm run preview'
//             }
//         }
//     }
// }



// pipeline {
//     agent {
//         docker {
//             image 'alpine'
//         }
//     }

//     stages {
//         stage('Sanity') {
//             steps {
//                 echo 'RUNNING INSIDE DOCKER'
//                 sh 'cat /etc/os-release'
//             }
//         }
//     }
// }


// pipeline {
//     agent {
//         docker {
//             image 'node-docker-cli:20-alpine'
//             args '-v /var/run/docker.sock:/var/run/docker.sock'
//         }
//     }

//     triggers {
//         githubPush()
//     }

//     environment {
//         APP_NAME = "jenkins-deployment"
//         IMAGE_TAG = "jenkins-deployment:latest"
//         DEPLOY_PORT = "3000"
//     }

//     stages {
//         stage('Install Dependencies') {
//             steps {
//                 echo 'Installing Dependencies...'
//                 sh 'npm install'
//             }
//         }

//         stage('Build') {
//             steps {
//                 echo 'Building application...'
//                 sh 'npm run build'
//             }
//         }

//         stage('Test') {
//             steps {
//                 echo 'Running Tests...'
//                 sh 'npm test -- --watchAll=false'
//             }
//         }

//         stage('Setup Docker CLI') {
//             steps {
//                 echo 'Installing Docker CLI inside agent container...'
//                 sh 'apk add --no-cache docker-cli'
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 echo 'Building Docker image...'
//                 sh """
//                     docker build -t ${IMAGE_TAG} .
//                     docker images | grep ${APP_NAME}
//                 """
//             }
//         }

//         stage('Deploy') {
//             steps {
//                 echo 'Deploying container...'
//                 sh """
//                     docker stop ${APP_NAME} || true
//                     docker rm ${APP_NAME} || true
//                     docker run -d -p ${DEPLOY_PORT}:3000 --name ${APP_NAME} ${IMAGE_TAG}
//                 """
//             }
//         }
//     }

//     post {
//         always {
//             echo 'Pipeline finished.'
//             sh 'docker ps'
//         }
//         failure {
//             echo 'Pipeline failed!'
//         }
//     }
// }



pipeline {
    agent {
        // docker {
        //     image 'node-docker-cli:20-alpine'
        //     args '-v /var/run/docker.sock:/var/run/docker.sock'
        // }
        label 'docker-agent-node'
    }

    triggers {
        githubPush()
    }

    environment {
        APP_NAME = "jenkins-deployment"
        IMAGE_TAG = "jenkins-deployment:latest"
        DEPLOY_PORT = "3000"
        DOCKER_HOST = "tcp://docker-socat:2375"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                echo 'Installing Dependencies...'
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                echo 'Building application...'
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                echo 'Running Tests...'
                sh 'npm test -- --watchAll=false'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh """
                    docker build -t ${IMAGE_TAG} .
                    docker images | grep ${APP_NAME}
                """
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying container...'
                sh """
                    docker ps -a --format '{{.Names}}' | grep -q "^${APP_NAME}\$" && docker rm -f ${APP_NAME} || true
                    docker run -d -p ${DEPLOY_PORT}:3000 --name ${APP_NAME} ${IMAGE_TAG}
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
            sh 'docker ps'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
