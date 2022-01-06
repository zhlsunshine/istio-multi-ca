#!/bin/bash

clear
export KUBECONFIG=/etc/kubernetes/admin.conf
echo "<Step 1>: Display the cluster with one master and work node."
kubectl get nodes -o wide
echo "________________________________________________________________________________________"

read -p "Please press any keyboard to continue." 
clear
echo "<Step 2>: Make sure that cert-manager is working well."
kubectl get pods -n cert-manager -o wide
echo "________________________________________________________________________________________"

read -p "Please press any keyboard to continue."
clear
echo "<Step 3>: Create selfsigned ClusterIssuer of cert-manager for namespaces 'bar', 'foo' and 'istio-system'"
cd selfsigned-issuer
./create-selfsigned.sh
cd ..
echo "________________________________________________________________________________________"

read -p "Please press any keyboard to continue."
clear
echo "<Step 4>: Install Istio with configuration file."
cd istio
cat istio-certs.yaml
read -p "Please press any keyboard to continue."
clear
echo "Begin to install Istio."
./deploy-istio.sh
echo "Completed installation."
cd ..
echo "________________________________________________________________________________________"

read -p "Please press any keyboard to continue."
clear
echo "<Step 5>: Deploy workloads in namespace 'bar' and 'foo'."
cd workload
echo "Deploy workload in namespace bar"
./wl-bar.sh
echo "________________________________________________________________________________________"

read -p "Please press any keyboard to continue."
clear

echo "Deploy workload in namespace foo."
./wl-foo.sh
cd ..
echo "________________________________________________________________________________________"

read -p "Please press any keyboard to continue."
clear
echo "<Step 6>: Verify the network connectivity inside every namespace via curl."
cd verification/in-namespace
echo "Check in namespace bar."
./bar.sh
echo ""
read -p "Please press any keyboard to continue."
echo "Check in namespace foo."
./foo.sh
echo ""
echo "________________________________________________________________________________________"
echo ""

read -p "Please press any keyboard to continue."
clear
echo "<Step 7>: Verify the network connectivity inside every namespace via istioctl."
./istioctl-verify.sh
cd -
echo "________________________________________________________________________________________"
echo ""


read -p "Please press any keyboard to continue."
clear
echo "<Step 8>: Verify the network connectivity across namespaces via curl."
cd verification/across-namespace
echo "Check from sleep.bar to httpbin.foo"
./bar.sh
echo ""
read -p "Please press any keyboard to continue."
echo "Check from sleep.foo to httpbin.bar"
./foo.sh
echo ""
echo "________________________________________________________________________________________"
echo ""

read -p "Please press any keyboard to continue."
clear
echo "<Step 9>: Verify the network connectivity across namespaces via istioctl."
./istioctl-verify.sh
cd -
echo "________________________________________________________________________________________"

