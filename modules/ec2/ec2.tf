resource "aws_instance" "example" {
    count = "${length(var.public_ids)}"
    ami = "ami-09e67e426f25ce0d7"
    #ami = "ami-0c1a7f89451184c8b"
    instance_type = "t2.micro"
    subnet_id = "${element(var.public_ids, count.index)}"
    associate_public_ip_address = true
    vpc_security_group_ids = "${[var.ssh_groupid]}"
    key_name = "helloworld"

}

resource "aws_key_pair" "deployer" {
  key_name   = "helloworld"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDbjJaUai+gI0OHEqFScjsrf18MO93qBFPgIZyNXJt2gGIzWkH8spD1W62S41Ol0oGFwgHlj3rBNz3I+9u7IFulVNW/ONBRfrqxHf8qtIdBIlbtBq9bFQ3DLHsgUTArplxd2IzJ+u2CNe67dUlSQEJ97aXJQy+aky2A5cQsdFYocosLhKNjJ8qp5AE43DzAAi4HMTi9jsTIzfORqz2LmwoVShODDCtTXbbiPmnQFaaRse1N4wWelZE66Sovvq/Vp5hoxygCO6BiJ8U1BMSEs2aI3XWu1Z9o/OWZ4hqJGTtHKHmwhvqgRSYKlVhnjF/tNp2HB1WjqonZe7+rdCpPP1glhd2ef78znP7AL+NmoIw0qreC6Y8eWwakN05U3wftR586r+MeyEK3iZNb6hRFNhHJR8HlF+nViQs/UEMSdpLv9OI/aVyx1ALUQ7TlcouIEtiX3bH73FQrjkiSCeD8d8T7NETEFM3r8HM4GE4AK1knQZiKWU25ZuXel33K807lTU= ineshreddy@Ineshs-MBP.Dlink"
}