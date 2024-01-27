// public subnet
variable "public_subnet_cidrs"{
    type = list(string)
    description = "Public subnet CIDR valus"
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

// private subnet
variable "private_subnet_cidrs"{
    type = list(string)
    description = "Public subnet CIDR valus"
    default = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
}

// availability zone
variable "azs"{
    type = list(string)
    description = "Availability Zones"
    default = ["us-east-2a","us-east-2b","us-east-2c"]
}  

