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