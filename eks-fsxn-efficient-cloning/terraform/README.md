## Start Demo environemnt

## Prerequisites
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) on your workstation/server
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your workstation/server


## Variables
- `aws_region` AWS region to deploy the demo (default: `us-east-2`)
- `kubernetes_version`  EKS version to provision (default: `1.21`)
- `vpc_cidr` the VPC CIDR range (default: `10.0.0.0/16`)
- `fsx_name` the fsx filesystem name (default: `eksfs`)
- `fsx_admin_password` the fsx admin password (default: `Netapp1!`)
- `fsx_capacity` the fsx storage capacity (default: `2048`)

## Run
Run the following to start your eks environment:
```bash
terraform init
terraform apply --auto-approve
```

After the environement is up run the following to update your kubeconfig file (you can get the `cluster_name` value from the cluster_name output in terraform)
```bash
aws eks --region=<aws_region> update-kubeconfig --name <cluster_name>
```

To test the environemet run the following:
``` bash
kubectl get nodes -o wide
```
