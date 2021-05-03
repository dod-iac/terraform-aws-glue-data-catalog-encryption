/**
 * # Glue Catalog Encryption
 *
 * ## Description
 *
 * Add account-wide encryption to the Glue Catalog
 *
 * ## Usage
 *
 * Resources:
 *
 * * [Encrypt Glue Data Catalog](https://docs.aws.amazon.com/glue/latest/dg/encrypt-glue-data-catalog.html)
 * * [Encrypting Connection Passwords](https://docs.aws.amazon.com/glue/latest/dg/encrypt-connection-passwords.html)
 *
 * ```hcl
 * module "glue_kms_key" {
 *   source = "dod-iac/glue-kms-key/aws"
 *
 *   name = format("alias/app-%s-glue-%s", var.application, var.environment)
 *
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 *
 * module "glue_data_catalog_encryption" {
 *   source = "dod-iac/glue-data_catalog-encryption/aws"
 *
 *   aws_kms_key_arn = module.glue_kms_key.aws_kms_key_arn
 * }
 * ```
 *
 * Now when you define a crawler or a job, The IAM role that you provide in the definition must have these AWS KMS permissions:
 *
 * ```json
 * {
 *     "Version": "2012-10-17",
 *     "Statement": [
 *         {
 *             "Effect": "Allow",
 *             "Action": [
 *                 "kms:Decrypt",
 *                 "kms:Encrypt",
 *                 "kms:GenerateDataKey"
 *             ],
 *             "Resource": "ARN-of-key-used-to-encrypt-data-catalog"
 *         }
 *     ]
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 *
 * ## Developer Setup
 *
 * Install dependencies (macOS)
 *
 * ```shell
 * brew install pre-commit terraform terraform-docs
 * pre-commit install --install-hooks
 * ```
 *
 */

resource "aws_glue_data_catalog_encryption_settings" "main" {
  data_catalog_encryption_settings {
    connection_password_encryption {
      aws_kms_key_id                       = var.aws_kms_key_arn
      return_connection_password_encrypted = true
    }

    encryption_at_rest {
      catalog_encryption_mode = "SSE-KMS"
      sse_aws_kms_key_id      = var.aws_kms_key_arn
    }
  }
}
