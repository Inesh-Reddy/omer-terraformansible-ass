output "vpc_id" {
    value = "${aws_vpc.main.id}"
}

# output for private subnet id
output "private_ids" {
    value = "${aws_subnet.private.*.id}"
}

#output for public subnet id
output "public_ids" {
    value = "${aws_subnet.public.*.id}"
}
#output id of security group that allows ssh
output "ssh_groupid" {
    value = "${aws_security_group.allow_ssh.id}"

}

output "db_groupid" {
    value = "${aws_security_group.db_connection.id}"
}



#############
output "public_ip" {
  description = "Contains the public IP address"
  value       = aws_eip.nat.public_ip
}


