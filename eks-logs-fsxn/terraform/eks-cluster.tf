module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.5.0"
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets

  enable_irsa = true
  cluster_endpoint_public_access = true

  authentication_mode = "API"
  enable_cluster_creator_admin_permissions = true 

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    fsx_group = {
      min_size     = 2
      max_size     = 6
      desired_size = 2

      enable_bootstrap_user_data = true

      pre_bootstrap_user_data = data.cloudinit_config.cloudinit.rendered
    }
  }
}

data "cloudinit_config" "cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = file("scripts/iscsi.sh")
  }
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}

resource "aws_eks_addon" "fsxn_csi_addon" {
  cluster_name = module.eks.cluster_name
  addon_name   = "netapp_trident-operator"
  addon_version = var.fsxn_addon_version
  resolve_conflicts_on_create = "OVERWRITE"


  configuration_values = jsonencode({
    cloudIdentity = "'eks.amazonaws.com/role-arn: ${module.iam_iam-role-for-service-accounts-eks.iam_role_arn}'"
  })
}