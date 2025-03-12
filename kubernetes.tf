provider "kubernetes" {
    host = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_name
}

resource "kubernetes_deployment" "giropops" {
    depends_on = [ module.eks ] # vai garantir que o cluster EKS esteja criado antes de criar o deployment

    metadata {
        name = "giropops"
        labels = {
            app = "giropops"
        }
    }

    spec {
        replicas = 2

        selector {
            match_labels = {
                app = "giropops-senhas"
            }
        }

        template {
            metadata {
                labels = {
                    app = "giropops-senhas"
                }
            }

            spec {
                container {
                    image = "rrany/giropops-senhas:${var.image_tag}"
                    name = "giropops-senhas"
                    port {
                        container_port = 8080
                    }

                    env {
                        name = "REDIS_HOST"
                        value = "redis-service"
                    }
                }
            }
        }
    }
  
}

resource "kubernetes_service" "giropops_senhas" {
    metadata {
        name = "giropops-senhas"
        labels = {
            app = "giropops-senhas"
        }
    }

    spec {
        selector = {
            app = "giropops-senhas"
        }

        port {
            port = 80
            target_port = 5000
        }

        type = "LoadBalancer"
    }
  
}

resource "kubernetes_deployment" "redis" {
    metadata {
        name = "redis"
        labels = {
            app = "redis"
        }
    }

    spec {
        replicas = 1

        selector {
            match_labels = {
                app = "redis"
            }
        }

        template {
            metadata {
                labels = {
                    app = "redis"
                }
            }

            spec {
                container {
                    image = "redis"
                    name = "redis"
                    port {
                        container_port = 6379
                    }
                }
            }
        }
    }  
}

resource "kubernetes_service" "redis" {
    metadata {
        name = "redis-service"
        labels = {
            app = "redis"
        }
    }

    spec {
        selector = {
            app = "redis"
        }

        port {
            port = 6379
            target_port = 6379
        }
    }
  
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1
resource "kubernetes_ingress_v1" "giropops_senhas" {
    metadata {
        name = "giropops-senhas-ingress"
        annotations = {
            "kubernetes.io/ingress.class" = "nginx"
            "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
        }
    }

    spec {
        rule {
          host = "giropops.rany.fun"
          http {
            path {
                path = "/"
                backend {
                  service {
                    name = kubernetes_service.giropops_senhas.metadata[0].name
                    port {
                      number = 80
                    }
                  }
                }
            }
          }
        }

        tls {
            hosts = ["giropops.rany.fun"]
            secret_name = "giropops-rany-fun-tls"
        }
    }
}