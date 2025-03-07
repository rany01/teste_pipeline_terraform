# saída do endpoint do cluster EKS
output "eks_cluster_endpoint" {
    value = module.eks.cluster_endpoint
    description = "Endpoint do cluster EKS"
}

# Saída do nome do cluster EKS
output "eks_cluster_name" {
    value = module.eks.cluster_name
    description = "Nome do cluster EKS"
}

# Saída do endpoint do Load Balancer da aplicação
output "giropops_senhas_lb" {
    value = kubernetes_service.giropops_senhas.status[0].load_balancer.0.ingress[0].hostname
    description = "Endpoint do Load Balancer da aplicação"
}

# Saída do kubeconfig (para uso local)
# aws eks update-kubeconfig --name giropops-cluster --region us-east-1
# cat ~/.kube/config | base64
# 