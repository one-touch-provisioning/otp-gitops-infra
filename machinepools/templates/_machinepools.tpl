{{/*
MachinePools Header
{{ $params := dict "Values" .Values "Name" .Name "Zone" "{{ . }}"}}
*/}}

{{- define "machinepools.header" -}}
{{- $params := dict "Values" .Values "Name" .Name -}}
apiVersion: hive.openshift.io/v1
kind: MachinePool
metadata:
  name: {{ $.Values.cloud.clusterName }}-{{ .Name }}
  labels:
    {{- if eq .Name "infra" }}
    machine.openshift.io/cluster-api-machine-role: {{ .Name }}
    machine.openshift.io/cluster-api-machine-type: {{ .Name }}
    node-role.kubernetes.io/infra: ""
    {{- else if eq .Name "storage" }}
    machine.openshift.io/cluster-api-machine-role: infra
    machine.openshift.io/cluster-api-machine-type: infra
    node-role.kubernetes.io/infra: ""
    cluster.ocs.openshift.io/openshift-storage: ""
    {{- else if eq .Name "cp4x" }}
    machine.openshift.io/cluster-api-machine-role: worker
    machine.openshift.io/cluster-api-machine-type: worker
    node-role.kubernetes.io/cp4x: ""
    {{- end }}
  annotations:
    argocd.argoproj.io/sync-wave: "360"
    helm.sh/hook-weight: "360"
  namespace: {{ $.Values.cloud.clusterName }}
spec:
  {{- if and (eq .Name "storage") (or $.Values.cloud.storageNodes.taints $.Values.global.storageNodes.taints) }}
  taints:
  {{- toYaml (default $.Values.global.storageNodes.taints $.Values.cloud.storageNodes.taints) | nindent 4 -}}
  {{- end -}}
  {{- if and (eq .Name "infra") (or $.Values.cloud.infraNodes.taints $.Values.global.infraNodes.taints) }}
  taints:
  {{- toYaml (default $.Values.global.infraNodes.taints $.Values.cloud.infraNodes.taints) | nindent 4 -}}
  {{- end -}}
  {{- if and (eq .Name "cp4x") (or $.Values.cloud.cloudpakNodes.taints $.Values.global.cloudpakNodes.taints) }}
  taints:
  {{- toYaml (default $.Values.global.cloudpakNodes.taints $.Values.cloud.cloudpakNodes.taints) | nindent 4 -}}
  {{- end -}}
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