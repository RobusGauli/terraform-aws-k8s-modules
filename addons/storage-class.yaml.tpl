---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: queue-resiliance
  namespace: kube-system
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  fsType: ext4
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true

---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mongo-optimized-for-logs
provisioner: kubernetes.io/aws-ebs
parameters:
  type: io1
  iopsPerGB: "100"
  fsType: xfs
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true

---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mongo-optimized-for-journal
provisioner: kubernetes.io/aws-ebs
parameters:
  type: io1
  iopsPerGB: "250"
  fsType: xfs
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true

---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mongo-optimized-for-data
provisioner: kubernetes.io/aws-ebs
parameters:
  type: io1
  iopsPerGB: "1000"
  fsType: xfs
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
