resource "aws_iam_policy" "rds-1" {
    name = "rds-policy"
    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "rds:ModifyRecommendation",
                "rds:CancelExportTask",
                "rds:DescribeDBEngineVersions",
                "rds:CrossRegionCommunication",
                "rds:DescribeExportTasks",
                "rds:StartExportTask",
                "rds:DescribeEngineDefaultParameters",
                "rds:DeleteDBInstanceAutomatedBackup",
                "rds:DescribeRecommendations",
                "rds:DescribeReservedDBInstancesOfferings",
                "rds:ModifyCertificates",
                "rds:DescribeRecommendationGroups",
                "rds:DescribeOrderableDBInstanceOptions",
                "rds:DescribeEngineDefaultClusterParameters",
                "rds:DescribeSourceRegions",
                "rds:CreateDBProxy",
                "rds:DescribeCertificates",
                "rds:DescribeEventCategories",
                "rds:DescribeAccountAttributes",
                "rds:DescribeEvents"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "rds:*",
            "Resource": [
                "arn:aws:rds:*:066343538601:og:*",
                "arn:aws:rds:*:066343538601:pg:*",
                "arn:aws:rds:*:066343538601:subgrp:*",
                "arn:aws:rds:*:066343538601:snapshot:*",
                "arn:aws:rds:*:066343538601:secgrp:*",
                "arn:aws:rds:*:066343538601:cluster:*",
                "arn:aws:rds:*:066343538601:cluster-pg:*",
                "arn:aws:rds:*:066343538601:db:*",
                "arn:aws:rds:*:066343538601:target-group:*",
                "arn:aws:rds:*:066343538601:es:*",
                "arn:aws:rds:*:066343538601:db-proxy:*",
                "arn:aws:rds:*:066343538601:cev:*/*/*",
                "arn:aws:rds:*:066343538601:cluster-snapshot:*"
            ]
        }
    ]
})
  
}


resource "aws_iam_role" "rds-role" {
    name = "rdsrole"
    assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sts:AssumeRole"
            ],
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "rds.amazonaws.com"
                ]
            }
        }
    ]
})
tags = {
  "Name" = "rds-role"
}
}

resource "aws_iam_role_policy_attachment" "rds-attach" {
  role       = aws_iam_role.rds-role.name
  policy_arn = aws_iam_policy.rds-1.arn
}









