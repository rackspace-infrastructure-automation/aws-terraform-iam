provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

##################################
# Standard EC2 Managed Role Test #
##################################
module "iam_policy" {
  source = "../../module"

  name = "EC2-Web-Server"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  ]
}

######################
# Inline Policy Test #
######################
module "iam_policy" {
  source = "../../module"
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
