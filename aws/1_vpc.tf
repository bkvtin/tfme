module "backbone_foo_stash_label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.9.0"
  namespace   = "aws"
  environment = "backbone"
  stage       = "foo"
  name        = "stash"
}

# define our VPC
resource "aws_vpc" "backbone_foo_stash" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = "${var.vpc_dns["default"]}"

  tags {
    Name = "${module.backbone_foo_stash_label.id}"
  }
}

# define the public subnet
resource "aws_subnet" "backbone_foo_stash_public_subnet" {
  vpc_id = "${aws_vpc.backbone_foo_stash.id}"

  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${var.aws_zone["ue_1a"]}"

  tags {
    Name = "${module.backbone_foo_stash_label.id}-public"
  }
}

# define the private subnet
resource "aws_subnet" "backbone_foo_stash_private_subnet" {
  vpc_id            = "${aws_vpc.backbone_foo_stash.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${var.aws_zone["ue_1b"]}"

  tags {
    Name = "${module.backbone_foo_stash_label.id}-private"
  }
}

# define the internet gateway
resource "aws_internet_gateway" "backbone_foo_stash_gateway" {
  vpc_id = "${aws_vpc.backbone_foo_stash.id}"

  tags {
    Name = "${module.backbone_foo_stash_label.id}-gateway"
  }
}

# define the route table
resource "aws_route_table" "backbone_foo_stash_route_table" {
  vpc_id = "${aws_vpc.backbone_foo_stash.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.backbone_foo_stash_gateway.id}"
  }

  tags {
    Name = "${module.backbone_foo_stash_label.id}-route-table"
  }
}

# ssign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id      = "${aws_subnet.backbone_foo_stash_public_subnet.id}"
  route_table_id = "${aws_route_table.backbone_foo_stash_route_table.id}"
}
