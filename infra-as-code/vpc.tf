resource "aws_vpc" "k8s_cluster" {
  cidr_block = var.vpc_cidr

  tags = tomap({
    "Name"                                      = "terraform-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_subnet" "k8s_cluster" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.200.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.k8s_cluster.id

  tags = tomap({
    "Name"                                      = "terraform-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_internet_gateway" "k8s_cluster" {
  vpc_id = aws_vpc.k8s_cluster.id

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_route_table" "k8s_cluster" {
  vpc_id = aws_vpc.k8s_cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_cluster.id
  }
}

resource "aws_route_table_association" "k8s_cluster1" {

  subnet_id      = aws_subnet.k8s_cluster.0.id
  route_table_id = aws_route_table.k8s_cluster.id
}

resource "aws_route_table_association" "k8s_cluster2" {

  subnet_id      = aws_subnet.k8s_cluster.1.id
  route_table_id = aws_route_table.k8s_cluster.id
}

