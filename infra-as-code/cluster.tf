resource "aws_eks_cluster" "hello_world" {
  name     = var.cluster-name
  role_arn = aws_iam_role.k8s_cluster.arn
  version = "1.20"

  vpc_config {
    security_group_ids = [aws_security_group.k8s_cluster.id]
    subnet_ids         = aws_subnet.k8s_cluster[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.k8s_cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.k8s_cluster-AmazonEKSVPCResourceController,
  ]
}
