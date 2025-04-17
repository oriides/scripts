#!/usr/bin/env bash

# install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable traefik --prefer-bundled-bin --kubelet-arg containerd=/run/k3s/containerd/containerd.sock" sh -s -

# update kubeconfig
cp "${KUBECONFIG}" "${KUBECONFIG}.old"
kubectl config delete-context k3s || true
kubectl config delete-user k3s || true
kubectl config delete-cluster k3s || true
sudo install -m 600 -o "${USER}" -g "${USER}" /etc/rancher/k3s/k3s.yaml /tmp/k3s.config
sed -i "s/default/k3s/g" /tmp/k3s.config
KUBECONFIG="${KUBECONFIG}:/tmp/k3s.config" kubectl config view --merge --flatten > /tmp/new.config
mv /tmp/new.config "${KUBECONFIG}"
rm /tmp/k3s.config

# set k3s as default context
kubectl config set-context k3s
