pipeline {
    agent any

    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm', '386'], description: 'Pick ARCH')
    }

    environment {
        REPO = 'https://github.com/MikityukVarvara/kbot'
        BRANCH = 'develop'
        TARGETARCH = "${params.ARCH}"
        TARGETOS = "${params.OS}"
    }

    stages {
        stage("YOUR SETTINGS") {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"
            }
        }

        stage("clone") {
            steps {
                echo "CLONE REPOSITORY"
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }

        stage("test") {
            steps {
                echo "TEST EXECUTION STARTED"
                sh "make test"
            }
        }

        stage("image") {
            steps {
                echo "BUILD EXECUTION STARTED"
                sh "make image"
            }
        }

        stage("push") {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub') {
                        sh "make push"
                    }
                }
            }
        }
    }
}
