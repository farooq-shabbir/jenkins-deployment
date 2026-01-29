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



pipeline {
    agent {
        docker {
            image 'alpine'
        }
    }

    stages {
        stage('Sanity') {
            steps {
                echo 'RUNNING INSIDE DOCKER'
                sh 'cat /etc/os-release'
            }
        }
    }
}
