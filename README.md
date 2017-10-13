# IAM Module

Creates IAM roles that can be applied to instances, services or users. The primary
function facilitates assuming AWS managed policies by creating the policy
document and creating the role. Inline policies can be created within the parent
template, and attached with the output of this module.

## Variables
| Name | Description | Default |
| --- | --- | --- |
|name|Name for IAM Role.|
|managed_policy_arns|A list of managed policy ARNs.|
|principal_type|The type of principal.|`Service`|
|principal_identifiers|A list of principal entities allowed to assume this role. | `["ec2.amazonaws.com"]`|

## Usage
### Standard EC2 Managed Role
```hcl
module "iam_policy" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam"

  name = "EC2-Web-Server"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  ]
}
```

### Apply Inline Policy
```hcl
module "iam_policy" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam"
  name = "EC2-Web-Server"
}

resource "aws_iam_role_policy" "instance_role_policies" {
  name   = "EC2-Web-Server-InlinePolicy"
  role   = "${module.iam_policy.instance_role_name}"
  policy = "${data.aws_iam_policy_document.instance_role_policy_document.json}"
}

data "aws_iam_policy_document" "instance_role_policy_document" {
  statement {
    actions = [
      "cloudformation:Describe*",
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "ssm:CreateAssociation",
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }
}
```
