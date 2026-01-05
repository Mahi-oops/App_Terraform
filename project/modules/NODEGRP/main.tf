resource "aws_eks_node_group" "node_grp" {
    cluster_name = var.EKS_CLUSTER_NAME
    node_group_name = "${var.EKS_CLUSTER_NAME}-node-group"
    node_role_arn = var.NODE_GROUP_ARN
    subnet_ids = [var.private_ID1, var.private_ID2]

    scaling_config {
        desired_size = 2
        max_size = 2
        min_size = 2
    }

 ami_type = "AL2_x86_64"
 capacity_type = "ON_DEMAND"
 force_update_version = false
 instance_types = ["t3.small"]
 disk_size = 20
 labels = {
    role = "${var.EKS_CLUSTER_NAME}-Node-group-role",
    name = "${var.EKS_CLUSTER_NAME}-node-group"
 }

 version = "1.34"
}