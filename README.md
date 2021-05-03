<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# Glue Catalog Encryption

## Description

Add account-wide encryption to the Glue Catalog

## Usage

Resources:

* [Encrypt Glue Data Catalog](https://docs.aws.amazon.com/glue/latest/dg/encrypt-glue-data-catalog.html)
* [Encrypting Connection Passwords](https://docs.aws.amazon.com/glue/latest/dg/encrypt-connection-passwords.html)

```hcl
module "glue_kms_key" {
  source = "dod-iac/glue-kms-key/aws"

  name = format("alias/app-%s-glue-%s", var.application, var.environment)

  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}

module "glue_catalog_encryption" {
  source = "dod-iac/glue-catalog-encryption/aws"

  aws_kms_key_arn = module.glue_kms_key.aws_kms_key_arn
}
```

Now when you define a crawler or a job, The IAM role that you provide in the definition must have these AWS KMS permissions:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:GenerateDataKey"
            ],
            "Resource": "ARN-of-key-used-to-encrypt-data-catalog"
        }
    ]
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit terraform terraform-docs
pre-commit install --install-hooks
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
