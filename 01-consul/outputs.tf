output "kubernetes_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "kubernetes_cluster_id" {
  value = module.eks.cluster_name
}

output "vpc" {
  value = {
    vpc_id = aws_vpc.main.id
  }
}
