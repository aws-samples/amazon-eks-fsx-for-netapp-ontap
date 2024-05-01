
resource "aws_iam_policy" "fsxn-csi-policy" {
  name        = "AmazonFSXNCSIDriverPolicy"
  description = "FSxN CSI Driver Policy"


  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "fsx:DescribeFileSystems",
                "fsx:DescribeVolumes",
                "fsx:CreateVolume",
                "fsx:RestoreVolumeFromSnapshot",
                "fsx:DescribeStorageVirtualMachines",
                "fsx:UntagResource",
                "fsx:UpdateVolume",
                "fsx:TagResource",
                "fsx:DeleteVolume"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "secretsmanager:GetSecretValue",
            "Resource": "${aws_secretsmanager_secret.fsxn_password_secret.arn}"
        }
    ]
    })
}


module "iam_iam-role-for-service-accounts-eks" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.37.1"

  role_name              = "AmazonEKS_FSXN_CSI_DriverRole"
  allow_self_assume_role = true

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["${local.k8s_service_account_namespace}:${local.k8s_service_account_name}"]
    }
  }

  role_policy_arns = {
    additional           = aws_iam_policy.fsxn-csi-policy.arn
  }

}

locals {
    k8s_service_account_namespace = "trident"
    k8s_service_account_name      = "trident-controller"
}

resource "aws_secretsmanager_secret" "fsxn_password_secret" {
  name = "fsxn_password_secret"
  description = "FSxN CSI Driver Password"
}

resource "aws_secretsmanager_secret_version" "fsxn_password_secret" {
    secret_id     = aws_secretsmanager_secret.fsxn_password_secret.id
    secret_string = jsonencode({
    username = "vsadmin"
    password = "${random_string.fsx_password.result}"
  })
}

