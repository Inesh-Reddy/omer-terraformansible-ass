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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmd3w9l+6+U/43WBCfEHsLg2cEbkOw8fJEgnF4dDgAgE32VcLRrb42xOFhYrGZChltiyOgbdxLFxxvWbQtzOsSE5y3GYrcoYqh75z1s5F6QzVyDdySZSYK9p0T5gN0LOxgEGZY/txGrQN5lyRPw5D2a3wncCxS8LHNkR+je2LzjIgsVclzkoui6RsFVuWpan2eNYjfrnbmA3LgIbpvBjO1YPu7m5skwum8tCDOIej38Fg7QBheHyqF0YcLFFdP3noILFa9zyJ4D0WEPIvdC2q4jmpIgWMVT38cu2rZwD1qbdS7hNFeY8n6toEtdrcEWE301NHhf1GtgRattD7BxW1bvUbP1fxpsOUu/9gb1+HIe/kuOSwQXkLlTWK6XZcURuIA4noR4Jm/iZH/SPnJnw7EbZzLmJ7Ts5w6cGVrtJIHE0cxGpMU83kGOxTv6qdWm33i04qre83tHLA5NXkRjONtj5FnboVnr6y+HT4TBmMa5ecH0Edc/eOZZB6Aoexw1AU= ineshreddy@Ineshs-MBP.Dlink"
}