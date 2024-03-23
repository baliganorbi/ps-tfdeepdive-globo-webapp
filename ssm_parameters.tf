locals {
  host_list_ssm_name = "/${local.name_prefix}/host-list"
  site_name_ssm_name = "/${local.name_prefix}/site-name"
}

# host-list ssm paremeter resource
resource "aws_ssm_parameter" "host_list" {
  name  = local.host_list_ssm_name
  type  = "StringList"
  value = join(",", aws_instance.main.*.private_dns)
}

# site-name ssm paremeter resource
resource "aws_ssm_parameter" "site_name" {
  name  = local.site_name_ssm_name
  type  = "String"
  value = "${local.name_prefix}-taco-wagon"
}

# policy document for ssm parameter access
data "aws_iam_policy_document" "ssm_access" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]
    resources = [
      aws_ssm_parameter.host_list.arn,
      aws_ssm_parameter.site_name.arn,
    ]
  }
}

# iam policy for ssm parameter access
resource "aws_iam_policy" "ssm_access" {
  name   = "${local.name_prefix}-ssm-access"
  policy = data.aws_iam_policy_document.ssm_access.json
}

# iam policy attachment for ssm parameter access
resource "aws_iam_role_policy_attachment" "ssm_access" {
  role       = var.ec2_iam_role_name
  policy_arn = aws_iam_policy.ssm_access.arn
}