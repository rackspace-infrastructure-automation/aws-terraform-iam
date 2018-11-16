module "iam_policy" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam"

  name = "EC2-Web-Server"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  ]
}
