terraform {
    required_version = "~> 1.1.7"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.8.0"
        }
    }
}

provider "aws" {
    region = var.region
}

#call to module vpc

module vpc {
    source = "./vpc"

    cidr_vpc= var.cidr_vpc
    cidr_subnet = var.cidr_subnet 
}

#call to module s3

module s3 {
    source = "./s3"

}

#call to module ec2

module ec2 {
    source = "./ec2"

    ami_server= var.ami_server
    type_server = var.server_type
    subnet_id = {
        public = module.vpc.subnet_2_id
        private = module.vpc.subnet_1_id
    }
    vpc_cidr = var.cidr_vpc
    vpc_id = module.vpc.vpc_id

}