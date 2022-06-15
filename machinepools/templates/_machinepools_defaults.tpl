{{/*
Default Machinepools Replica Count
{{ $params := dict "Values" .Values "Name" .Name}}
*/}}

{{- define "machinepools.defaultReplicaCount" -}}
{{- if eq $.Values.cloudProvider.name "aws" -}}
{{- if eq .Name "storage" -}}
{{- default "3" .Values.cloud.storageNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "3" .Values.cloud.infraNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "0" .Values.cloud.cloudpakNodes.nodeCount }}
{{- end -}}
{{- end }}
{{- if eq $.Values.cloudProvider.name "azure" -}}
{{- if eq .Name "storage" -}}
{{- default "3" .Values.cloud.storageNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "3" .Values.cloud.infraNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "0" .Values.cloud.cloudpakNodes.nodeCount }}
{{- end -}}
{{- end -}}
{{- if eq $.Values.cloudProvider.name "vsphere" -}}
{{- if eq .Name "storage" -}}
{{- default "3" .Values.vsphere.storageNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "3" .Values.vsphere.infraNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "0" .Values.vsphere.cloudpakNodes.nodeCount }}
{{- end -}}
{{- end -}}
{{- if eq $.Values.cloudProvider.name "ibmcloud" -}}
{{- if eq .Name "storage" -}}
{{- default "3" .Values.cloud.storageNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "3" .Values.cloud.infraNodes.nodeCount }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "0" .Values.cloud.cloudpakNodes.nodeCount }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Default Node Sizes
{{ $params := dict "Values" .Values "Name" .Name}}
*/}}

{{- define "machinepools.defaultNodeSize" -}}
{{- if eq $.Values.cloudProvider.name "aws" -}}
{{- if eq .Name "storage" -}}
{{- default "m5.4xlarge" .Values.cloud.storageNodes.instanceType }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "m5.2xlarge" .Values.cloud.infraNodes.instanceType }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "m5.2xlarge" .Values.cloud.cloudpakNodes.instanceType }}
{{- end -}}
{{- end }}
{{- if eq $.Values.cloudProvider.name "azure" -}}
{{- if eq .Name "storage" -}}
{{- default "Standard_D16s_v3" .Values.cloud.storageNodes.instanceType }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "Standard_D8s_v3" .Values.cloud.infraNodes.instanceType }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "Standard_D8s_v3" .Values.cloud.cloudpakNodes.instanceType }}
{{- end -}}
{{- end -}}
{{- if eq $.Values.cloudProvider.name "ibmcloud" -}}
{{- if eq .Name "storage" -}}
{{- default "bx2d-16x64" .Values.cloud.storageNodes.instanceType }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "bx2d-4x16" .Values.cloud.infraNodes.instanceType }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "bx2d-8x32" .Values.cloud.cloudpakNodes.instanceType }}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Default Node Volume Type
{{ $params := dict "Values" .Values "Name" .Name}}
*/}}

{{- define "machinepools.defaultNodeVolumeType" -}}
{{- if eq $.Values.cloudProvider.name "aws" -}}
{{- if eq .Name "storage" -}}
{{- default "gp2" .Values.cloud.storageNodes.volumeType }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "gp2" .Values.cloud.infraNodes.volumeType }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "gp2" .Values.cloud.cloudpakNodes.volumeType }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Default IOPS for AWS
{{ $params := dict "Values" .Values "Name" .Name}}
*/}}

{{- define "machinepools.defaultNodeIopsSize" -}}
{{- if eq $.Values.cloudProvider.name "aws" -}}
{{- if eq .Name "storage" -}}
{{- default "4000" .Values.cloud.storageNodes.volumeIops }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "4000" .Values.cloud.infraNodes.volumeIops }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "4000" .Values.cloud.cloudpakNodes.volumeIops }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Default Node Volume Size
{{ $params := dict "Values" .Values "Name" .Name}}
*/}}

{{- define "machinepools.defaultNodeVolumeSize" -}}
{{- if eq $.Values.cloudProvider.name "aws" -}}
{{- if eq .Name "storage" -}}
{{- default "128" .Values.cloud.storageNodes.volumeSize }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "128" .Values.cloud.infraNodes.volumeSize }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "128" .Values.cloud.cloudpakNodes.volumeSize }}
{{- end -}}
{{- end }}
{{- if eq $.Values.cloudProvider.name "azure" -}}
{{- if eq .Name "storage" -}}
{{- default "128" .Values.cloud.storageNodes.volumeSize }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "128" .Values.cloud.infraNodes.volumeSize }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "128" .Values.cloud.cloudpakNodes.volumeSize }}
{{- end -}}
{{- end -}}
{{- end -}}


{{- define "machinepools.vsphere.defaultNodeCPU" -}}
{{- if eq .Name "storage" -}}
{{- default "16" $.Values.vsphere.storageNodes.numCPUs }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "8" $.Values.vsphere.infraNodes.numCPUs }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "8" $.Values.vsphere.cloudpakNodes.numCPUs }}
{{- end -}}
{{- end -}}

{{- define "machinepools.vsphere.NodeCoresPerSocket" -}}
{{- if eq .Name "storage" -}}
{{- default "1" $.Values.vsphere.storageNodes.numCoresPerSocket }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "1" $.Values.vsphere.infraNodes.numCoresPerSocket }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "1" $.Values.vsphere.cloudpakNodes.numCoresPerSocket }}
{{- end -}}
{{- end -}}

{{- define "machinepools.vsphere.defaultNodeMemory" -}}
{{- if eq .Name "storage" -}}
{{- default "65536" $.Values.vsphere.storageNodes.memoryMiB }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "16384" $.Values.vsphere.infraNodes.memoryMiB }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "32768" $.Values.vsphere.cloudpakNodes.memoryMiB }}
{{- end -}}
{{- end -}}

{{- define "machinepools.vsphere.defaultNodeDiskSize" -}}
{{- if eq .Name "storage" -}}
{{- default "120" $.Values.vsphere.storageNodes.diskGiB }}
{{- end -}}
{{- if eq .Name "infra" -}}
{{- default "120" $.Values.vsphere.infraNodes.diskGiB }}
{{- end -}}
{{- if eq .Name "cp4x" -}}
{{- default "120" $.Values.vsphere.cloudpakNodes.diskGiB }}
{{- end -}}
{{- end -}}
