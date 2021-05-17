# Git test

- Execute shell
echo "git test project"
echo '${env.BUILD_ID}'


# ibm-github-checkout
Source Code Management 
Radio button: Git
Need to pass Git credentials

# demo-2
check box: This project is parameterized
Pipeline
    - pipeline script
  ~~~
  pipeline {
    agent {
        label '!windows'
    }

    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
    }

    stages {
        
    stage('Checkout Source') {
        steps {
            git url:'https://github.com/atulchauhan01/kubernetes-yaml-files.git', branch:'master'
        }
        }
        
        stage('Build') {
            steps {
                echo "path is ${PATH}"
                sh 'echo ehllo'
                echo "${BUILD_ID}"
                echo "Before sed ---------->"
                //sh "cat ./deployment-from-git/deployment/nginx-deployment.yaml"
                //sh "sed -i 's;IMAGE;${DB_ENGINE};g' ./deployment-from-git/deployment/nginx-deployment.yaml"
                echo "after sed ---------->${DB_ENGINE}"
                //sh "cat ./deployment-from-git/deployment/nginx-deployment.yaml"
                echo "workspce  $workspace"
            }
        }
        
/*      stage('Run Helm') {
          steps {
              script {      
              container('helm') {
                sh "helm ls"
               }
              } 
          }
	  }*/
        
/*        stage('Deploy App') {
        steps {
            withCredentials([
                string(credentialsId: 'my_kubernetes', variable: 'api_token')
                ]) {
                 sh 'kubectl --token $api_token --server https://172.21.228.8:8443 --insecure-skip-tls-verify=true run nginx  --image=nginx '
                   }
            }
        }*/
        
/*        stage('Deploy App') {
        steps {
            withCredentials([
                string(credentialsId: 'my_kubernetes', variable: 'api_token')
                ]) {
                 sh 'kubectl --token $api_token --server https://172.26.210.4:8443 --insecure-skip-tls-verify=true apply -f deployment/deployment-definition.yaml '
                   }
            }
        }*/
        
        stage('Deploy App') {
        steps {
            withCredentials([
                string(credentialsId: 'iks_jenkins_secrets', variable: 'api_token')
                ]) {
                 sh 'kubectl --token $api_token --server https://c6.mil01.containers.cloud.ibm.com:21086 --insecure-skip-tls-verify=true apply -f deployment/deployment-definition.yaml '
                   }
            }
        }           

    		   
    }
}
~~~

# nested-stages
~~~
pipeline {

    agent any

    environment {
        CLUSTER    = 'dev'
    }

    stages {

        stage('Zero'){
            steps {
                echo 'Zero stage'

                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo "Testing the ${browsers[i]} browser"
                    }

                    if (true) {
                        echo 'in if condition'
                    } else {
                        echo 'in else condition'
                    }
                }
            }

        }

        stage('One') {
            steps {
                echo 'Hi, this is Zulaikha from edureka'
            }
        }

        stage('Two') {
            steps {
            input('Do you want to proceed?')
            }
        }

        stage('Three') {
            when {
                not {
                    branch "master"
                }
            }
            steps {
                echo "Hello"
            }
        }

        stage('deploy to non-prod cluster') {      
            // environment based canditon can be used for execution control      
            when { 
                environment name: 'CLUSTER', value: 'dev' 
            }
            steps {
                echo "ENVIRONMENT CHECK"
            }
        }

        stage('Four') {
            when { 
                environment name: 'CLUSTER', value: 'dev' 
            }
            failFast true
            parallel { 
                stage('Unit Test') {
                    steps {
                        echo "Running the unit test..."
                    }
                }
/*
                stage('Integration test') {
                    agent {
                        docker {
                                reuseNode true
                                image 'ubuntu'
                                }
                        }
                    steps {
                        echo "Running the integration test..."
                    }
                }
*/

            }
        }
    }
}
~~~

# kubernetes-deployment-script
~~~
pipeline {

    agent any
    
     parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }
 
    

    environment {
        TAG    = 'nginx:latest'
        dockerHubUser = 'atulchauhan01'
        dockerHubPassword = 'Vel@09876'
        dockerImage = 'atulchauhan01/hello-world-test'
        registry = 'atulchauhan01/hello-world-test'
    }    

    stages {

   
        stage('Example') {
            steps {
                echo "Hello ${params.PERSON}"

                echo "Biography: ${params.BIOGRAPHY}"

                echo "Toggle: ${params.TOGGLE}"

                echo "Choice: ${params.CHOICE}"

                echo "Password: ${params.PASSWORD}"
            }
        }

/*        stage('Checkout Source') {
        steps {
            git url:'https://github.com/atulchauhan01/kubernetes-yaml-files.git', branch:'master'
        }
        }
*/
/*    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "echo ${env.dockerHubPassword} | docker login --username ${env.dockerHubUser} --password-stdin"
          sh "docker pull atulchauhan01/hello-world-test"
          sh "docker push atulchauhan01/hello-world-test"
        }
      }
    }*/
    
/*    stage('Deploy our image') {
    	steps{
    		script {
    			docker.withRegistry( '', 'dockerhub' ) {
    			dockerImage.push()
    			}
    		}
    	}
    }  */     
        
        stage('Update image tag and deploy') {
            steps {
                echo "path is ${PATH}"
                sh 'echo ehllo'
                echo "${BUILD_ID}"
                echo "Before sed ---------->"
                
                sh "sed -i 's;IMAGE;${TAG};g' ./deployment/deployment-sed-image-tag.yaml"
                echo "after sed ---------->${TAG}"
                

/*                script {
                    kubernetesDeploy(configs: "deployment/*", kubeconfigId: "iks_kubeconfig")
                }*/
            }
        }
        
/*        stage('Deploy App using sh command (without plugin)') {
            steps {
                withCredentials([
                    string(credentialsId: 'iks_jenkins_secrets', variable: 'api_token')
                    ]) {
                    sh 'kubectl --token $api_token --server https://c6.mil01.containers.cloud.ibm.com:21086 --insecure-skip-tls-verify=true apply -f deployment/deployment-definition.yaml '
                    }
            }
        } */     
        
/*    stage('Apply Kubernetes Files') {
      steps {
          withKubeConfig([credentialsId: 'iks_kubeconfig']) {
          sh 'kubectl apply -f deployment/deployment-definition.yaml'
        }
      }
    }*/
        
/*       stage('var-substitution and deploy') {
            steps {
                script {
                    kubernetesDeploy(configs: "deployment/deployment-var-substitution.yaml", kubeconfigId: "my_kubeconfig")
                }
            }
        }*/

/*        stage('Deploy App') {
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
*/
    }
    

}
~~~

# iks-cluster-deployment-scm
- https://github.com/atulchauhan01/kubernetes-yaml-files.git/
  
  
# 