output "access_key" {
  value = aws_iam_access_key.cloudwatch_exporter.id
}

output "secret_key" {
  value = aws_iam_access_key.cloudwatch_exporter.encrypted_secret
}
