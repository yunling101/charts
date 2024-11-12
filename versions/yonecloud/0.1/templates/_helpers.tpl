{{/*
Expand the name of the chart.
*/}}
{{- define "yonecloud.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "yonecloud.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Values.name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "yonecloud.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "yonecloud.labels" -}}
helm.sh/chart: {{ include "yonecloud.chart" . }}
{{ include "yonecloud.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "yonecloud.selectorLabels" -}}
app.kubernetes.io/name: {{ include "yonecloud.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "yonecloud.legacy.labels" -}}
heritage: {{ .Release.Service }}
release: {{ .Release.Name }}
chart: {{ .Chart.Name }}
app: "{{ template "yonecloud.name" . }}"
{{- end -}}

{{- define "yonecloud.mysql.encryptedPassword" -}}
  {{- .Values.mysql.password | b64enc | quote -}}
{{- end -}}

{{- define "yonecloud.mysql.encryptedSecretKey" -}}
  {{- .Values.secretKey | b64enc | quote -}}
{{- end -}}

{{- define "yonecloud.redis" -}}
  {{- printf "%s-redis" (include "yonecloud.fullname" .) -}}
{{- end -}}