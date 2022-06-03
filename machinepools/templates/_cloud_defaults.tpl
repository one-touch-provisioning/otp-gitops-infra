{{/*
Default list of Zones per CloudProvider
*/}}

{{- define "cloud.zones" -}}
	{{- if eq .Values.cloudProvider.name "aws" -}}
		{{ default (list "a" "b" "c") .Values.cloud.zones }}
	{{- end }}
	{{- if eq $.Values.cloudProvider.name "azure" -}}
		{{ default (list "1" "2" "3") .Values.cloud.zones }}
	{{- end }}
	{{- if eq $.Values.cloudProvider.name "ibmcloud" -}}
        {{ default (list "1" "2" "3") .Values.cloud.zones }}
    {{- end }}
{{- end }}
