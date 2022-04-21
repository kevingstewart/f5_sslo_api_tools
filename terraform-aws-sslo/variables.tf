## Add a prefix to objects in SSLO - this will make identifying your config easier
variable "prefix" {
  description = "Type a prefix name to keep your SSLO objects unique"
  type        = string 
  default     = "kstew_sslo4_"
}


## Replace this with your SSH Keypair name 
## You should have created a key pair in advance, if not go create one!
variable "ec2_key_name" {
  description = "AWS EC2 Key name for SSH access"
  type        = string
  default     = "kstewart_keypair"
}


## Region - Change Your Region Here
variable "region" {
  description = "Set the Region"
  type        = string
  default     = "us-east-1"
}


## Availability Zone - Set Your AZ
variable "az" {
  description = "Set Availability Zone"
  type        = string
  default     = "us-east-1a"
}


## Jump Box AMI - Change AMI to whatever, the world is your oyster!
variable "jumpbox_ami" {
  description = "Windows Server 2019 Base"
  type        = string
  default     = "ami-0aad84f764a2bd39a"
}


## BIG-IP AMI - Change AMI to whatever, the world is your oyster!
variable "sslo_ami" {
  description = "BIG-IP version 15.1.1"
  type        = string
  default     = "ami-06ceb79f3482bd83c"
}


## Inspection AMI - Change AMI to whatever, the world is your oyster!
variable "inspection_ami" {
  description = "Snort Network Intrusion and Detection System"
  type        = string
  default     = "ami-0cdc9ccb73322825f"
}


## Webapp Test AMI - Change AMI to whatever, the world is your oyster!
variable "webapp_ami" {
  description = "Test webb app"
  type        = string
  default     = "ami-05343502b4149e010"
}



