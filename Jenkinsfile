pipeline {
    agent any
    triggers {
        githubPush()
    }
    stages {
        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }
        stage('Build') {
            steps {
                bat 'npm run build'
            }
        }
        stage('Test') {
            steps {
                bat 'npm test -- --watchAll=false'
            }
        }
        stage('Deploy') {
            steps {
                bat 'npm run preview'
            }
        }
    }
}