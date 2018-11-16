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
