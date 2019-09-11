# Requester connection details - initiates the request.
#
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "${data.aws_vpc.requester_vpc.id}"
  peer_vpc_id   = "${data.aws_vpc.acceptor_vpc.id}"
  peer_owner_id = "${data.aws_caller_identity.peer.account_id}"
  peer_region   = "${data.aws_region.peer.id}"
  auto_accept   = false

  timeouts {
    create = "2m"
  }

  tags {
    Name        = "${var.requester_vpc_name} to ${var.acceptor_vpc_name}"
    Environment = "${var.requester_environment}"
    Service     = "${var.service}"
    BillingCode = "${var.billing_code}"
  }
}

# Acceptor connection details - accepts the request.
#
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.acceptor"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags {
    Name        = "${var.acceptor_vpc_name} to ${var.requester_vpc_name}"
    Environment = "${var.acceptor_environment}"
    Service     = "${var.service}"
    BillingCode = "${var.billing_code}"
  }
}
