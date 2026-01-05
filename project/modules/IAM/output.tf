output "EKS_CLUSTER_ROLE_ARN" {
  value = aws_iam_role.iam_eks_cluster_role.arn
}

output "NODE_GROUP_ROLE_ARN" {
  value = aws_iam_role.iam_node_group_role.arn
}