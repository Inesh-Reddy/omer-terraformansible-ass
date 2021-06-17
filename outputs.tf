### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  ec2-ip = aws_instance.example.instance_public_ip,
  rds-ip = aws_eip.nat.public_ip,
  rds-password = aws_db_instance.my_db.password
  rds-username = aws_db_instance.my_db.username
  
 }
 )
 filename = "inventory"
}