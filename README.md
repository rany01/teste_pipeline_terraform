# teste_pipeline_terraform
teste de pipeline do projeto terraform

**Deploy de Aplicação no EKS com Terraform e CI/CD**
  

## TODO
 - Adiconar o Cert-Manager no ingress para ter o HTTPS

---
**Objetivo**: Automatizar a infraestrutura e o deployment da aplicação  **giropops senhas** no Kubernetes (EKS) usando Terraform e GitHub Actions.

### **Tecnologias utilizadas**:
- **Terraform**: Provisionamento da infraestrutura.
- **AWS EKS**: Gerenciamento do cluster Kubernetes.
- **Docker Hub**: Armazenamento das imagens do container.
- **GitHub Actions**: CI/CD pipeline para deploy contínuo.
  
### **Arquitetura**

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 18.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment.giropops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_deployment.redis](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_ingress_v1.giropops_senhas](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_service.giropops_senhas](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service.redis](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Tag da imagem Docker | `string` | `"latest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | Endpoint do cluster EKS |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | Nome do cluster EKS |
| <a name="output_giropops_senhas_lb"></a> [giropops\_senhas\_lb](#output\_giropops\_senhas\_lb) | Endpoint do Load Balancer da aplicação |
<!-- END_TF_DOCS -->