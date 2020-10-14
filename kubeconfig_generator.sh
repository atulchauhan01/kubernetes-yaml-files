# https://stackoverflow.com/questions/47770676/how-to-create-a-kubectl-config-file-for-serviceaccount
# your server name goes here
server=https://c6.mil01.containers.cloud.ibm.com:21086
# the name of the secret containing the service account token goes here
name=jenkins-token-9hj5q

ca=$(kubectl get secret/$name -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret/$name -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret/$name -o jsonpath='{.data.namespace}' | base64 --decode)

echo "
apiVersion: v1
kind: Config
clusters:
- name: mycluster-free/bu28p4tf02c9vpr2mja0
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: jenkins-default-context
  context:
    cluster: mycluster-free/bu28p4tf02c9vpr2mja0
    namespace: default
    user: jenkins-token-9hj5q
current-context: jenkins-default-context
users:
- name: jenkins-token-9hj5q
  user:
    token: ${token}
" > sa.kubeconfig