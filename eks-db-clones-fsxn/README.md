# Amazon EKS and Amazon FSx for NetApp ONTAP - The most efficient way to run your and clone your containerized databases

This repo comes as an appendix to the the "Manage your containerised stateful applications efficiently using Amazon FSx for NetApp ONTAP and Amazon EKS" blog post. It will help you build the demo enviroment and run the code samples that are mendioned throughout the blog.

## Prerequisites

- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) on your workstation/server
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your workstation/server

## Content

- [terraform](/terraform) - terraform code to start a demo environment in AWS with
- [manifests](/manifests) - kubernetes yaml samples that are used throughout the blog

## Security

See [CONTRIBUTING](../CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
