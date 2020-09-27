variable "region" {
  type        = string
  description = "AWS Region"
}


variable "namespace" {
  description = "Namespace (e.g. `singular` or `sg`)"
  type        = string
  default     = ""
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = string
  default     = ""
}


variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = string
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "bucket_name" {
  description = "Unique Name for S3 Bucket"
  type        = "string"
}

variable "aws_acm_certificate_arn" {
  type = "string"
}

variable "cloudfront_origin_id" {
  description = "Unique Origin ID for CDN"
  type        = "string"
}

variable "cloudfront_domain_aliases" {
  description = "A list of Domain names the need to associated with the CDN"
  type        = "list"
  default     = []
}
