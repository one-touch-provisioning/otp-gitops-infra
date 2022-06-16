

{{- define "node.taints" -}}
{{- if and (eq .Name "storage") $.Values.cloud.storageNodes.taints }}
taints:
{{- toYaml $.Values.cloud.storageNodes.taints | nindent 6 -}}
{{- end -}}
{{- if and (eq .Name "infra") $.Values.cloud.infraNodes.taints }}
taints:
{{- toYaml $.Values.cloud.infraNodes.taints | nindent 6 }}
{{- end -}}
{{- if and (eq .Name "cp4x") $.Values.cloud.cloudpakNodes.taints }}
taints:
{{- toYaml $.Values.cloud.cloudpakNodes.taints | nindent 6 -}}
{{- end -}}
{{- end -}}
