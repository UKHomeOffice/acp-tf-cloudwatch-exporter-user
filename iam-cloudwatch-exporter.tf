resource "aws_iam_user" "cloudwatch_exporter" {
  name  = "${var.name}-cloudwatch-exporter"
  path  = "/"

  tags = var.tags
}

resource "aws_iam_access_key" "cloudwatch_exporter" {
  user    = aws_iam_user.cloudwatch_exporter.name
  pgp_key = data.aws_ssm_parameter.kinesis_users_public_key.value
}

resource "aws_iam_user_policy_attachment" "cloudwatch_exporter_policy" {
  user       = aws_iam_user.cloudwatch_exporter.name
  policy_arn = aws_iam_policy.cloudwatch_exporter_policy.arn
}

resource "aws_iam_policy" "cloudwatch_exporter_policy" {
  name        = "${var.name}_cloudwatch_exporter_policy"
  path        = "/"

  policy = data.aws_iam_policy_document.cloudwatch_exporter_document.json
}

data "aws_iam_policy_document" "cloudwatch_exporter_document" {

  statement {
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:List*",
      "cloudwatch:Get*",
      "tag:GetResources"
    ]

    resources = [
      "*"
    ]
  }
}
