resource "aws_iam_role" "iam_eks_cluster_role" {
    name = "${var.DEVOPS_PROJ}-EKS-ROLE"

    assume_role_policy = <<POLICY

    {
    "version": "2012-10-17",
    "statement": [
    {
    "Effect": "Allow",
    "Principal": {
       "service": "eks.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
       }
    ]
  }
 POLICY 
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
    
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.iam_eks_cluster_role.id
  
}

resource "aws_iam_role_policy_attachment" "Elasticloadbalancer_policy" {
    policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    role = aws_iam_role.iam_eks_cluster_role.id
  
}

resource "aws_iam_role" "iam_node_group_role" {
    name = "${var.DEVOPS_PROJ}-node_group-role"
    
    assume_role_policy = <<POLICY
    {
    "version": "2012-10-17",
    "Statement": [
    {
    "Effect": "Allow",
    "Principal": {
    "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
    } 
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "worker_node" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam_node_group_role.id
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam_node_group_role.id
}

resource "aws_iam_role_policy_attachment" "ECR_read_only" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam_node_group_role.id
}