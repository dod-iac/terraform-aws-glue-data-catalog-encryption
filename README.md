<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# Glue Catalog Encryption

## Description

Add account-wide encryption to the Glue Catalog

## Usage

Resources:

* [Encrypt Glue Data Catalog](https://docs.aws.amazon.com/glue/latest/dg/encrypt-glue-data-catalog.html)

```hcl

module "glue_kms_key" {
  source = "dod-iac/glue-kms-key/aws"

  name = format("alias/app-%s-glue-%s", var.application, var.environment)
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_glue_data_catalog_encryption_settings.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_data_catalog_encryption_settings) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_kms_key_arn"></a> [aws\_kms\_key\_arn](#input\_aws\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_glue_catalog_id"></a> [glue\_catalog\_id](#output\_glue\_catalog\_id) | The AWS Glue Catalog ID. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
