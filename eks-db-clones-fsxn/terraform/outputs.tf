output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "fsx-management-ip" {
  value = format("%s=%s", "FSX_MANAGEMENT_IP", join("", aws_fsx_ontap_file_system.eksfs.endpoints[0].management[0].ip_addresses))
}

output "fsx-password" {
  value = format("%s=%s", "FSX_PASSWORD", random_string.fsx_password.result)
}
output "fsx-svm-name" {
  value = format("%s=%s", "FSX_SVM_NAME", aws_fsx_ontap_storage_virtual_machine.ekssvm.name)
}
output "fsx-svm-id" {
  value = format("%s=%s", "FSX_SVM_ID", aws_fsx_ontap_storage_virtual_machine.ekssvm.id)
}

output "zz_update_kubeconfig_command" {
  # value = "aws eks update-kubeconfig --name " + module.eks.cluster_id
  value = format("%s %s %s %s", "aws eks update-kubeconfig --name", module.eks.cluster_name, "--region", var.aws_region)
}

output "zz_non_root_volumes_env" {
  # value = "aws fsx describe-volumes  --filters "Name=storage-virtual-machine-id,Values=svm-0d368605da427d399" | jq -r '.Volumes[] | select(.OntapConfiguration.StorageVirtualMachineRoot==false) | .VolumeId''
  # value = format("NON_ROOT_VOLUMES=$(%s=%s %s)", "aws fsx describe-volumes  --filters \"Name=storage-virtual-machine-id,Values", aws_fsx_ontap_storage_virtual_machine.ekssvm.id, "\" | jq -r '.Volumes[] | select(.OntapConfiguration.StorageVirtualMachineRoot==false) | .VolumeId'")
  value = format("NON_ROOT_VOLUMES=$(%s=%s %s)", "aws fsx describe-volumes  --filters Name=storage-virtual-machine-id,Values", aws_fsx_ontap_storage_virtual_machine.ekssvm.id, " | jq -r '.Volumes[] | select(.OntapConfiguration.StorageVirtualMachineRoot==false) | .VolumeId'")
}
