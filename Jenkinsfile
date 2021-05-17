pipeline {

    agent any

    environment {
        TAG    = 'nginx:latest'
        dockerHubUser = 'atulchauhan01'
        dockerHubPassword = 'Vel@09876'
        registry = 'atulchauhan01/hello-world-test'
    }


    stages {

        stage('Checkout Source') {
            steps {
                git url:'https://github.com/atulchauhan01/kubernetes-yaml-files.git', branch:'master'
                git url: 'git@github.ibm.com:cmus/sim.git', credentialsId: 'ibm_github_credentials',  branch:'master'
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
                    kubernetesDeploy(configs: "deployment/deployment-sed-image-tag.yaml", kubeconfigId: "iks_kubeconfig")
                }
            }
        }
        
        stage('var-substitution and deploy') {
            steps {
                script {
                    kubernetesDeploy(configs: "deployment/deployment-var-substitution.yaml", kubeconfigId: "iks_kubeconfig")
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

    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "echo ${env.dockerHubPassword} | docker login --username ${env.dockerHubUser} --password-stdin"
          sh "docker push atulchauhan01/hello-world-test"
        }
      }
    } 

/*

*/        
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