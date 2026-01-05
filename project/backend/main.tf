module "VPC" {
  source = "../modules/vpc"
  REGION = var.REGION
  DEVOPS_PROJ = var.DEVOPS_PROJ
  VPC_CIDR = var.VPC_CIDR
  PUBLIC_CIDR_SUB1 = var.PUBLIC_CIDR_SUB1
  PUBLIC_CIDR_SUB2 = var.PUBLIC_CIDR_SUB2
  PRI_CIDR_SUB1 = var.PRI_CIDR_SUB1
  PRI_CIDR_SUB2 = var.PRI_CIDR_SUB2
}

module "NATGW" {
  source = "../modules/NATGW"
  IGW_ID = module.VPC.IGW_ID
  VPC_ID = module.VPC.VPC_ID
  public_ID1 = module.VPC.PUBLIC_CIDR_SUB1
  public_ID2 = module.VPC.PUBLIC_CIDR_SUB2
  private_ID1 = module.VPC.PRI_CIDR_SUB1
  private_ID2 = module.VPC.PRI_CIDR_SUB2
}
 
 module "IAM" {
   source = "../modules/IAM"
   DEVOPS_PROJ = var.DEVOPS_PROJ
 }

 module "EKS" {
    source = "../modules/EKS"
    DEVOPS_PROJ = var.DEVOPS_PROJ
    EKS_CLUSTER_ROLE_ARN = module.IAM.EKS_CLUSTER_ROLE_ARN
    PUBLIC_CIDR_SUB1 = module.VPC.PUBLIC_CIDR_SUB1
    PUBLIC_CIDR_SUB2 = module.VPC.PUBLIC_CIDR_SUB2    
    PRI_CIDR_SUB1 = module.VPC.PRI_CIDR_SUB1
    PRI_CIDR_SUB2 = module.VPC.PRI_CIDR_SUB2
 }

 module "NODEGRP" {
    source = "../modules/NODEGRP"
    EKS_CLUSTER_NAME = module.EKS.App_eks_cluster
    NODE_GROUP_ARN = module.IAM.NODE_GROUP_ROLE_ARN
    private_ID1 = module.VPC.PRI_CIDR_SUB1
    private_ID2 = module.VPC.PRI_CIDR_SUB2
 }