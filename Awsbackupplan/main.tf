resource "aws_iam_role" "myrole" {
  name               = "backuprole"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = "${aws_iam_role.myrole.name}"
}

resource "aws_backup_vault" "example" {
  name        = "test"
  
}

resource "aws_backup_plan" "myplan" {
  name = "tf_example_backup_plan"

  rule {
    rule_name         = "tf_example_backup_rule"
    target_vault_name = "${aws_backup_vault.example.id}"
    schedule          = "cron(0 12 * * ? *)"
  }

}

resource "aws_backup_selection" "example" {
  iam_role_arn = "${aws_iam_role.myrole.arn}"
  name         = "tf_example_backup_selection"
  plan_id      = "${aws_backup_plan.myplan.id}"


 resources = ["arn:aws:s3:::good-one-none"]
    
  
}