output "glue_catalog_id" {
  description = "The AWS Glue Catalog ID."
  value       = aws_glue_data_catalog_encryption_settings.main.id
}
