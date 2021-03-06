resource "aws_key_pair" "jumpstarter" {
    key_name   = "id_jumpstarter_${var.owner}"
    public_key = "${file("~/.ssh/id_rsa.pub")}"
}


data "aws_region" "current" {
    current = true
}


resource "aws_instance" "jumpstarter" {
    ami = "${lookup(var.amis, data.aws_region.current.name)}"
    instance_type = "${var.aws_instance_type}"

    vpc_security_group_ids      = ["${var.aws_vpc_security_group_id}"]
    subnet_id                   = "${var.aws_vpc_subnet_id}"
    associate_public_ip_address = true
    source_dest_check           = "${var.aws_instance_source_dest_check}"
    iam_instance_profile        = "${var.aws_instance_iam_profile}"

    associate_public_ip_address = true

    availability_zone = "${var.aws_zone}"
    key_name = "${aws_key_pair.jumpstarter.key_name}"

    tags {
      Name = "jumpstarter_${var.owner}"
      NodeType = "jumpstarter"
      Owner = "${var.owner}"
    }
}


output "Name" {
    value = "${aws_instance.jumpstarter.tags["Name"]}"
}


output "NodeType" {
    value = "${aws_instance.jumpstarter.tags["NodeType"]}"
}


output "Owner" {
    value = "${aws_instance.jumpstarter.tags["Owner"]}"
}

output "AwsRegion" {
    value = "${var.aws_region}"
}

output "AwsProfile" {
    value = "${var.aws_profile}"
}

output "IP" {
    value = "${aws_instance.jumpstarter.public_ip}"
}
