module "my_vpc" {
    source = "./modules/vpc"
    vpc_id = "${module.my_vpc.vpc_id}"

}

module "my_ec2" {
    source = "./modules/ec2"
    public_ids= "${module.my_vpc.public_ids}"
    ssh_groupid = "${module.my_vpc.ssh_groupid}"

}

module "my_rds" {
    source = "./modules/rds"
    private_ids = "${module.my_vpc.private_ids}"
    db_groupid = "${module.my_vpc.db_groupid}"
}

/*
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  ec2-ip = module.my_ec2.aws_instance.example.0.instance_public_ip,
  rds-ip = module.my_vpc.aws_eip.nat.public_ip,
  rds-password = module.my_rds.aws_db_instance.my_db.password
  rds-username = module.my_rds.aws_db_instance.my_db.username
  
 }
 )
 filename = "inventory"
}
*/


/*
resource "local_file" "inventory" {
    filename = "./host.ini"
    content     = <<_EOF
    [EC2]
	${module.my_ec2.aws_instance.example.0.instance_public_ip}
	[RDS]
	${module.my_vpc.aws_eip.nat.public_ip} 
    ansible_connection =ssh
    ansible_ssh_user = ${module.my_rds.aws_db_instance.my_db.username} 
    ansible_ssh_pass = ${module.my_rds.aws_db_instance.my_db.password}
    EOF
    }
    */


resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  ec2-ip = module.my_ec2.instance_public_ip,
  rds-ip = module.my_vpc.public_ip,
  
 }
 )
 filename = "inventory"
}