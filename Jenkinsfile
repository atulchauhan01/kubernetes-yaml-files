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

        stage('Update image tag using sed command and deploy') {
            steps {
                echo "path is ${PATH}"
                sh 'echo ehllo'
                echo "${BUILD_ID}"
                echo "Before sed ---------->"
                sh "cat ./deployment/deployment-sed-image-tag.yaml"
                sh "sed -i 's;IMAGE;${TAG};g' ./deployment/deployment-sed-image-tag.yaml"
                echo "after sed ---------->${TAG}"
                sh "cat ./deployment/deployment-sed-image-tag.yaml"

                script {
                    kubernetesDeploy(configs: "deployment/deployment-sed-image-tag.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }
        
        stage('var-substitution and deploy') {
            steps {
                script {
                    kubernetesDeploy(configs: "deployment/deployment-var-substitution.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }

        stage('Deploy App using sh command (without plugin)') {
            steps {
                withCredentials([
                    string(credentialsId: 'my_kubernetes', variable: 'api_token')
                    ]) {
                    sh 'kubectl --token $api_token --server https://172.21.228.8:8443 --insecure-skip-tls-verify=true apply -f deployment/deployment-definition.yaml '
                    }
            }
        }    
/*
        stage('Deploy Hellowhale App') {
            steps {
                script {
                    kubernetesDeploy(configs: "hellowhale.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }

        stage('Deploy Nginx App') {
            steps {
                script {
                kubernetesDeploy(configs: "deployment/deployment-definition.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }
*/
    }

}