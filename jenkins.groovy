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
        stage('YOUR SETTINGS') {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"
            }
        }

        stage('clone') {
            steps {
                echo "CLONE REPOSITORY"
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }
            stage('clone') {
            steps {
                echo "CLONE REPOSITORY"
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }
    }
}
