resource "aws_iam_role" "this" {
  name = "${var.app_name}-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.app_name}-bastion-profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_policy" "ssm_agent_aws_managed_s3_bucket" {
  name   = "${var.app_name}-ssm-agent-aws-managed-s3-bucket-bastion"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": [
                "arn:aws:s3:::aws-windows-downloads-${data.aws_region.this.name}/*",
                "arn:aws:s3:::amazon-ssm-${data.aws_region.this.name}/*",
                "arn:aws:s3:::amazon-ssm-packages-${data.aws_region.this.name}/*",
                "arn:aws:s3:::${data.aws_region.this.name}-birdwatcher-prod/*",
                "arn:aws:s3:::aws-ssm-document-attachments-${data.aws_region.this.name}/*",
                "arn:aws:s3:::patch-baseline-snapshot-${data.aws_region.this.name}/*",
                "arn:aws:s3:::aws-ssm-${data.aws_region.this.name}/*",
                "arn:aws:s3:::aws-patchmanager-macos-${data.aws_region.this.name}/*"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_server_policy" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "ssm_agent_aws_managed_s3_bucket" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.ssm_agent_aws_managed_s3_bucket.arn
}
