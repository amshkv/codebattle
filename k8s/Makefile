PWD:=$(shell pwd)

kb-%: export KUBECONFIG=$(PWD)/kubeconfig.yml
helm-%: export KUBECONFIG=$(PWD)/kubeconfig.yml

kb-get-pods:
	kubectl get pod -w -o wide

kb-get-nodes:
	kubectl get nodes

helm-init:
	helm install --name app $(PWD)/app-chart

helm-upgrade-app:
	helm upgrade app $(PWD)/app-chart

helm-install-ingress:
	helm install stable/nginx-ingress --name ingress --set rbac.create=true

helm-install-keel:
	helm repo add keel https://charts.keel.sh
	helm repo update
	helm upgrade --install keel --namespace keel keel/keel

kb-app-%: POD_NAME = $(shell kubectl get pod -l "app.kubernetes.io/instance=app" -o name --kubeconfig=$(KUBECONFIG))

kb-app-tailf:
	kubectl logs -f $(POD_NAME) -c app

kb-app-console:
	kubectl exec -it $(POD_NAME) -c app  -- bash
