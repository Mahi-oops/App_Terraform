resource "aws_eks_cluster" "App_eks_cluster" { 
    name = var.DEVOPS_PROJ

    role_arn = var.EKS_CLUSTER_ROLE_ARN

    version = "1.34"
    vpc_config {
      endpoint_private_access = false 
      endpoint_public_access = true
      subnet_ids = [
        var.PUBLIC_CIDR_SUB1,
        var.PUBLIC_CIDR_SUB2,
        var.PRI_CIDR_SUB1,
        var.PRI_CIDR_SUB2
      ]
    }
}      

