# https://stackoverflow.com/questions/47770676/how-to-create-a-kubectl-config-file-for-serviceaccount
# your server name goes here
server=https://c112.us-south.containers.cloud.ibm.com:31276
# the name of the secret containing the service account token goes here (specific to namespace)
name=jenkins-token-vc577

namespace=sim

ca=$(kubectl get secret/$name -n $namespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret/$name -n $namespace -o jsonpath='{.data.token}' | base64 --decode)
# namespace=$(kubectl get secret/$name -o jsonpath='{.data.namespace}' | base64 --decode)

echo "
apiVersion: v1
kind: Config
clusters:
- name: inventory-mgmt-np-dal/c154ol3d0en954gn63gg
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: jenkins-sim-context
  context:
    cluster: inventory-mgmt-np-dal/c154ol3d0en954gn63gg
    namespace: $namespace
    user: jenkins-token-vc577
current-context: jenkins-sim-context
users:
- name: jenkins-token-vc577
  user:
    token: ${token}
" > np-dal-sim-namespace.kubeconfig