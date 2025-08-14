{{- define "common.storageclass" -}}
{{- $ := index . "$" -}}
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: {{ .name | quote }}
  labels: {{- include "common.labels" $ | nindent 4 }}
    {{- with .labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- if or .annotations (ne .isDefaultClass nil) }}
  annotations:
    {{- with .isDefaultClass }}
    storageclass.kubernetes.io/is-default-class: {{ . | quote }}
    {{- end }}
    {{- with .annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
{{- with .allowVolumeExpansion }}
allowVolumeExpansion: {{ . }}
{{- end }}
{{- with .allowedTopologies }}
allowedTopologies: {{ . | toYaml | nindent 2 }}
{{- end }}
{{- with .mountOptions }}
mountOptions: {{ . | toYaml | nindent 2 }}
{{- end }}
{{- with .parameters }}
parameters: {{ . | toYaml | nindent 2 }}
{{- end }}
provisioner: {{ .provisioner | required "provisioner is required" }}
{{- with .reclaimPolicy }}
reclaimPolicy: {{ . | quote }}
{{- end }}
{{- with .volumeBindingMode }}
volumeBindingMode: {{ . | quote }}
{{- end }}
{{- end }}
