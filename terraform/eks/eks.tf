
module "eks" {
    source = "terraform-aws-modules/eks/aws"
    cluster_name = local.cluster_name
    cluster_version = "1.21"
    subnets = module.vpc.private_subnets
    cluster_endpoint_public_access = false
    cluster_endpoint_private_access = true
    cluster_endpoint_private_access_sg = [aws_security_group.eks_master_sg.id]

    vpc_id = module.vpc.vpc_id

    worker_groups = [
        {
            name = "worker-group1"
            asg_desired_capacity = 1
            additional_security_group_ids = [aws_security_group.worker_group1_sg.id]
        }
    ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

