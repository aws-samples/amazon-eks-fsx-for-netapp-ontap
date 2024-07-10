apiVersion: trident.netapp.io/v1
kind: TridentBackendConfig
metadata:
  name: backend-tbc-ontap-nas
  namespace: trident
spec:
  version: 1
  storageDriverName: ontap-nas
  backendName: tbc-ontap-nas
  svm: ${fs_svm}
  aws:
    fsxFilesystemID: ${fs_id}
  credentials:
    name: ${secret_arn}
    type: awsarn