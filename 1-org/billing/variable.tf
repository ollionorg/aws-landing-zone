variable "billing_format" {
  type        = string
  default     = "textORcsv"
  description = "Format for report. Valid values are: textORcsv, Parquet. If Parquet is used, then Compression must also be Parquet. Defaults to textORcsv"
}

variable "billing_compression" {
  type        = string
  default     = "GZIP"
  description = "Compression format for report. Valid values are: GZIP, ZIP, Parquet. If Parquet is used, then format must also be Parquet.Defaults to GZIP"
}

variable "billing_additional_schema_elements" {
  type        = list(string)
  default     = ["RESOURCES"]
  description = ") A list of schema elements. Valid values are: RESOURCES"
}

variable "billing_additional_artifacts" {
  type        = list(string)
  default     = []
  description = "A list of additional artifacts. Valid values are: REDSHIFT, QUICKSIGHT, ATHENA. When ATHENA exists within additional_artifacts, no other artifact type can be declared and report_versioning must be OVERWRITE_REPORT."
}

variable "billing_s3_prefix" {
  type        = string
  default     = ""
  description = "S3 prefix if needed."
}

variable "billing_report_versioning" {
  type        = string
  default     = "CREATE_NEW_REPORT"
  description = "Overwrite the previous version of each report or to deliver the report in addition to the previous versions. Valid values are: CREATE_NEW_REPORT and OVERWRITE_REPORT. Defaults to CREATE_NEW_REPORT"
}

variable "billing_refresh_closed_reports" {
  type        = bool
  default     = true
  description = "Set to true to update your reports after they have been finalized if AWS detects charges related to previous months."
}
