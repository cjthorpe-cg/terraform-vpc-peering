# Routes for the requester.
#
resource "aws_route" "peer_requester_peer_acceptor" {
  count                     = "${length(var.acceptor_cidr_block) * length(data.aws_route_tables.requester_route_tables.ids)}"
  route_table_id            = "${element(data.aws_route_tables.requester_route_tables.ids, (count.index+1)%length(data.aws_route_tables.requester_route_tables.ids))}"
  destination_cidr_block    = "${element(var.acceptor_cidr_block,ceil(count.index/length(data.aws_route_tables.requester_route_tables.ids)))}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  depends_on                = ["aws_vpc_peering_connection.peer"]
}

# Routes for the acceptor.
#
resource "aws_route" "peer_acceptor_peer_requester" {
  provider                  = "aws.acceptor"
  count                     = "${length(var.requester_cidr_block) * length(data.aws_route_tables.acceptor_route_tables.ids)}"
  route_table_id            = "${element(data.aws_route_tables.acceptor_route_tables.ids, (count.index+1)%length(data.aws_route_tables.acceptor_route_tables.ids))}"
  destination_cidr_block    = "${element(var.requester_cidr_block,ceil(count.index/length(data.aws_route_tables.acceptor_route_tables.ids)))}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  depends_on                = ["aws_vpc_peering_connection.peer"]
}
