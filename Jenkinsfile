pipeline {

    agent any

    environment {
        TAG    = 'nginx:latest'
    }


    stages {

        stage('Checkout Source') {
        steps {
            git url:'https://github.com/atulchauhan01/kubernetes-yaml-files.git', branch:'master'
        }
        }

        stage('Update image tag') {
            steps {
                echo "path is ${PATH}"
                sh 'echo ehllo'
                echo "${BUILD_ID}"
                echo "Before sed ---------->"
                sh "cat ./deployment-from-git/deployment/nginx-deployment.yaml"
                sh "sed -i 's;IMAGE;${TAG};g' ./deployment-from-git/deployment/nginx-deployment.yaml"
                echo "after sed ---------->${TAG}"
                sh "cat ./deployment-from-git/deployment/nginx-deployment.yaml"
            }
        }

        stage('Deploy App') {
            steps {
                script {
                kubernetesDeploy(configs: "hellowhale.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }

        stage('Deploy App-2') {
            steps {
                script {
                kubernetesDeploy(configs: "deployment/deployment-definition.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }

    }

}