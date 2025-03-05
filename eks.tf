module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "~> 18.0"

    cluster_name = "giropops-cluster"
    cluster_version = "1.32"

    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets

    eks_managed_node_groups = {
        default = {
            desired_size = 2
            max_size     = 3
            min_size     = 1
            instance_type    = "t3.medium"
        }
    }
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 3.0"

    name = "giropops-vpc"
    cidr = "10.0.0.0/16"

    azs = ["us-east-1a", "us-east-1b"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

    enable_nat_gateway = true
    single_nat_gateway = true
}