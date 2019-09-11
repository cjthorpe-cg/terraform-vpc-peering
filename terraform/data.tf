data "aws_vpc" "requester_vpc" {
  id = "${var.requester_vpc_id}"
}

data "aws_vpc" "acceptor_vpc" {
  provider = "aws.acceptor"
  id       = "${var.acceptor_vpc_id}"
}

data "aws_caller_identity" "peer" {
  provider = "aws.acceptor"
}

data "aws_region" "peer" {
  provider = "aws.acceptor"
}

# Discover route table IDs on the requester side. This requires the route tables to be tagged with 'Peering = True'
data "aws_route_tables" "requester_route_tables" {
  vpc_id = "${var.requester_vpc_id}"
  tags {
    Peering = "True"
  }
}

# Discover route table IDs on the acceptor side. This requires the route tables to be tagged with 'Peering = True'
data "aws_route_tables" "acceptor_route_tables" {
  provider = "aws.acceptor"

  vpc_id = "${var.acceptor_vpc_id}"
  tags {
    Peering = "True"
  }
}
