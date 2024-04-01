provider "aws" {
  region = "us-east-1"  # Remplacez par votre région AWS
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn = aws_iam_role.my_eks_cluster_role.arn

  vpc_config {
    subnet_ids = ["subnet-12345678", "subnet-23456789"] # Remplacez par les IDs de vos sous-réseaux
    security_group_ids = ["sg-12345678"] # Remplacez par l'ID de votre groupe de sécurité
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_iam_role" "my_eks_cluster_role" {
  name               = "my-eks-cluster-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.my_node_group_role.arn

  subnet_ids = ["subnet-12345678", "subnet-23456789"] # Remplacez par les IDs de vos sous-réseaux

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_iam_role" "my_node_group_role" {
  name               = "my-node-group-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
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
EOF
}
