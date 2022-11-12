


resource "aws_eks_node_group" "hello_world" {
  cluster_name    = aws_eks_cluster.hello_world.name
  node_group_name = "hello_world"
  node_role_arn   = aws_iam_role.k8s_node.arn
  subnet_ids      = aws_subnet.k8s_cluster[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  
  workers_additional_policies = [aws_iam_policy.worker_policy.arn]

  depends_on = [
    aws_iam_role_policy_attachment.k8s_node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.k8s_node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.k8s_node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_policy" "worker_policy" {
  name        = "worker-policy"
  description = "Worker policy for the ALB Ingress"

  policy = file("iam-policy.json")
}