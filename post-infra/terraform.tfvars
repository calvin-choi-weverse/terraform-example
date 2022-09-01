aws_region                                 = "ap-northeast-2"
account_id                                 = "692609349536"
eks_service_account_policy = {
    AmazonS3FullAccess       = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    AmazonDynamoDBFullAccess = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
    SecretsManagerReadWrite = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}
