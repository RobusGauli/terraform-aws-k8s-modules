---
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: perconaservermongodbs.psmdb.percona.com
spec:
  group: psmdb.percona.com
  names:
    kind: PerconaServerMongoDB
    listKind: PerconaServerMongoDBList
    plural: perconaservermongodbs
    singular: perconaservermongodb
    shortNames:
    - psmdb
  scope: Namespaced
  versions:
    - name: v1
      storage: true
      served: true
    - name: v1-2-0
      storage: false
      served: true
    - name: v1alpha1
      storage: false
      served: true
  additionalPrinterColumns:
    - name: Status
      type: string
      JSONPath: .status.state
    - name: Age
      type: date
      JSONPath: .metadata.creationTimestamp
  subresources:
    status: {}
---
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: perconaservermongodbbackups.psmdb.percona.com
spec:
  group: psmdb.percona.com
  names:
    kind: PerconaServerMongoDBBackup
    listKind: PerconaServerMongoDBBackupList
    plural: perconaservermongodbbackups
    singular: perconaservermongodbbackup
    shortNames:
    - psmdb-backup
  scope: Namespaced
  versions:
    - name: v1
      storage: true
      served: true
  additionalPrinterColumns:
    - name: Cluster
      type: string
      description: Cluster name
      JSONPath: .spec.psmdbCluster
    - name: Storage
      type: string
      description: Storage name from pxc spec
      JSONPath: .spec.storageName
    - name: Destination
      type: string
      description: Backup destination
      JSONPath: .status.destination
    - name: Status
      type: string
      description: Job status
      JSONPath: .status.state
    - name: Completed
      description: Completed time
      type: date
      JSONPath: .status.completed
    - name: Age
      type: date
      JSONPath: .metadata.creationTimestamp
  subresources:
    status: {}
---
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: perconaservermongodbrestores.psmdb.percona.com
spec:
  group: psmdb.percona.com
  names:
    kind: PerconaServerMongoDBRestore
    listKind: PerconaServerMongoDBRestoreList
    plural: perconaservermongodbrestores
    singular: perconaservermongodbrestore
    shortNames:
    - psmdb-restore
  scope: Namespaced
  versions:
    - name: v1
      storage: true
      served: true
  additionalPrinterColumns:
    - name: Cluster
      type: string
      description: Cluster name
      JSONPath: .spec.clusterName
    - name: Status
      type: string
      description: Job status
      JSONPath: .status.state
    - name: Age
      type: date
      JSONPath: .metadata.creationTimestamp
  subresources:
    status: {}
