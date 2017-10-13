output "instance_role_instance_profile_name" {
  value = "${aws_iam_instance_profile.instance_role_instance_profile.name}"
}

output "instance_role_name" {
  value = "${aws_iam_role.instance_role.name}"
}

output "instance_role_id" {
  value = "${aws_iam_role.instance_role.id}"
}
