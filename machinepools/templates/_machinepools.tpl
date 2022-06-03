{{/*
MachinePools Header
{{ $params := dict "Values" .Values "Name" .Name "Zone" "{{ . }}"}}
*/}}

{{- define "machinepools.clusterrole" -}}
{{- if eq .Name "cp4x" -}}
worker
{{- else -}}
{{- .Name -}}
{{- end -}}
{{- end -}}


{{- define "machinepools.header" -}}
{{- $params := dict "Values" .Values "Name" .Name -}}
apiVersion: hive.openshift.io/v1
kind: MachinePool
metadata:
  name: {{ $.Values.cloud.clusterName }}-{{ .Name }}
  annotations:
    argocd.argoproj.io/sync-wave: "360"
    helm.sh/hook-weight: "360"
  namespace: {{ $.Values.cloud.clusterName }}
spec:
{{- end -}}

{{/*
MachinePool ClusterDeploymentRef
*/}}

{{- define "machinepools.clusterdeploymentref" -}}
{{- $params := dict "Values" .Values "Name" .Name -}}
{{- if eq $.Values.cloudProvider.name "azure" -}}
{{- include "machinepools.clusterdeploymentref.azure" $params -}}
{{- end -}}
{{- if eq $.Values.cloudProvider.name "aws" -}}
{{- include "machinepools.clusterdeploymentref.aws" $params -}}
{{- end -}}
{{- if eq $.Values.cloudProvider.name "ibmcloud" -}}
{{- include "machinepools.clusterdeploymentref.ibmcloud" $params -}}
{{- end -}}
{{- if eq $.Values.cloudProvider.name "vsphere" -}}
{{- include "machinepools.clusterdeploymentref.vsphere" $params -}}
{{- end -}}
{{- end -}}



{{/*
MachinePool ClusterDeploymentRef
*/}}
{{- define "machinepools.clusterdeploymentref.azure" -}}
{{- $params := dict "Values" .Values "Name" .Name -}}
clusterDeploymentRef:
  name: {{ .Values.cloud.clusterName }}
name: {{ .Name }}
platform:
  azure:
    osDisk:
      diskSizeGB: {{ include "machinepools.defaultNodeVolumeSize" $params }}
    type: {{ include "machinepools.defaultNodeSize" $params }}
replicas: {{ include "machinepools.defaultReplicaCount" $params }}
{{- end -}}
{{- define "machinepools.clusterdeploymentref.aws" -}}
{{- $params := dict "Values" .Values "Name" .Name -}}
clusterDeploymentRef:
  name: {{ .Values.cloud.clusterName }}
name: {{ .Name }}
platform:
  aws:
    rootVolume:
      size: {{ include "machinepools.defaultNodeVolumeSize" $params }}
      iops: {{ include "machinepools.defaultNodeIopsSize" $params }} 
      type: {{ include "machinepools.defaultNodeVolumeType" $params }}
    type: {{ include "machinepools.defaultNodeSize" $params }}
replicas: {{ include "machinepools.defaultReplicaCount" $params }}
{{- end -}}
{{- define "machinepools.clusterdeploymentref.vsphere" -}}
{{- $params := dict "Values" .Values "Name" .Name -}}
clusterDeploymentRef:
  name: {{ .Values.vsphere.clusterName }}
name: {{ .Name }}
platform:
  vsphere:
    coresPerSocket: {{ include "machinepools.vsphere.NodeCoresPerSocket" . }}
    cpus: {{ include "machinepools.vsphere.defaultNodeCPU" . }}
    memoryMB: {{ include "machinepools.vsphere.defaultNodeMemory" . }} 
    osDisk:
      diskSizeGB: {{ include "machinepools.vsphere.defaultNodeDiskSize" . }}
replicas: {{ include "machinepools.defaultReplicaCount" $params }}
{{- end -}}
{{- define "machinepools.clusterdeploymentref.ibmcloud" -}}
{{- $params := dict "Values" .Values "Name" .Name -}}
clusterDeploymentRef:
  name: {{ .Values.cloud.clusterName }}
name: {{ .Name }}
platform:
  ibmcloud:
    type: {{ include "machinepools.defaultNodeSize" $params }}
replicas: {{ include "machinepools.defaultReplicaCount" $params }}
{{- end -}}