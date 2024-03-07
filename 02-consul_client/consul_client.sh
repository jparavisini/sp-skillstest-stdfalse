#!/bin/bash

kubeconfig_init() {
  # configure local kubeconfig
  cd ../01-consul
  aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw kubernetes_cluster_id)
  cd ../02-consul_client
}


echo "First execution? Type 0 or 1:"
read execution_attempt
if [ "$execution_attempt" == "1" ]; then
  kubeconfig_init
else
  echo "Skipping kubeconfig initialization..."
fi

# extract consul cluster connection details
CONSUL_ADDRESS="https://$(kubectl get services/consul-ui --namespace consul -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
CONSUL_TOKEN="$(kubectl get --namespace consul secrets/consul-bootstrap-acl-token --template={{.data.token}} | base64 -d)"
echo "Consul endpoint: ${CONSUL_ADDRESS}"

# configure env vars
export CONSUL_HTTP_ADDR=${CONSUL_ADDRESS}
export CONSUL_HTTP_TOKEN=${CONSUL_TOKEN}
export CONSUL_HTTP_SSL_VERIFY=false

# native client
# populate the database
consul kv put "customer/"
for i in {1..10}
do
  consul kv put "customer/com_acme_${i}/nodes_count" "$((1 + $RANDOM % 10))"
done

# getting values
#for i in {1..10}
#do
#  echo "customer/com_acme_${i}/nodes_count: $(consul kv get "customer/com_acme_${i}/nodes_count")"
#done

# dropping keys with even numbers
#for i in {1..10}
#do
#  if (( i % 2 != 0 ))
#  then
#    consul kv delete "customer/com_acme_${i}/nodes_count"
#  fi
#done

echo "Running py client..."
python3 consul_client.py #--consul-http-address "${CONSUL_ADDRESS}" --consul-http-token "${CONSUL_TOKEN}"

echo "Back in bash client..."
consul kv get -recurse "customer/com_acme"
