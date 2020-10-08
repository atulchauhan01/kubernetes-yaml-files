pipeline {

    agent any

    stages {

        stage('Checkout Source') {
        steps {
            git url:'https://github.com/atulchauhan01/kubernetes-yaml-files.git', branch:'master'
        }
        }

        stage('Deploy App') {
            steps {
                script {
                kubernetesDeploy(configs: "hellowhale.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }

    }

}