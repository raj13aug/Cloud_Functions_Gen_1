variable "name" {
  description = "Name of a Google Cloud Project"
  default     = "cloudroot7-demo"
}

variable "project_id" {
  type        = string
  description = "project id"
  default     = "mytesting-400910"
}

variable "region" {
  type        = string
  description = "Region of policy "
  default     = "us-central1"
}