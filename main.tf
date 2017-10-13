data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "${var.name}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_instance_profile" "instance_role_instance_profile" {
  name = "${var.name}-Profile"
  role = "${aws_iam_role.instance_role.name}"
}

resource "aws_iam_role_policy_attachment" "instance_role_policy_attachment" {
  count      = "${length(compact(var.managed_policy_arns))}"
  role      = "${aws_iam_role.instance_role.name}"
  policy_arn = "${var.managed_policy_arns[count.index]}"
}
