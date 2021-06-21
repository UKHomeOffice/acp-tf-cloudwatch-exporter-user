resource "aws_iam_user" "cloudwatch_exporter" {
  name  = "${var.name}-cloudwatch-metrics-exporter"
  path  = "/"

  tags = var.tags
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
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "tag:GetResources"
    ]

    resources = [
      "*"
    ]
  }
}

module "self_serve_access_keys" {
  source = "git::https://github.com/UKHomeOffice/acp-tf-self-serve-access-keys?ref=v0.1.0"

  user_names = [aws_iam_user.cloudwatch_exporter.name]
}
