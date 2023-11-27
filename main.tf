# Creación de la VPC
resource "aws_vpc" "move_vpc" {
    cidr_block           = var.vpc_cidr
    instance_tenancy     = "default"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
        app  = "move"
        Name = "move-vpc"
    }
}

# Creación de subredes
resource "aws_subnet" "move_subnet1" {
    vpc_id                  = aws_vpc.move_vpc.id
    cidr_block              = var.subnet_1_cidr
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        app  = "move"
        Name = "move-subnet-1"
    }
    depends_on = [
        aws_vpc.move_vpc
    ]
}

resource "aws_subnet" "move_subnet2" {
    vpc_id                  = aws_vpc.move_vpc.id
    cidr_block              = var.subnet_2_cidr
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        app  = "move"
        Name = "move-subnet-2"
    }
    depends_on = [
        aws_vpc.move_vpc
    ]
}

resource "aws_subnet" "move_subnet3" {
    vpc_id                  = aws_vpc.move_vpc.id
    cidr_block              = var.subnet_3_cidr
    availability_zone       = "us-east-1c"
    map_public_ip_on_launch = true
    tags = {
        app  = "move"
        Name = "move-subnet-3"
    }
    depends_on = [
        aws_vpc.move_vpc
    ]
}

resource "aws_subnet" "move_subnet4" {
    vpc_id                  = aws_vpc.move_vpc.id
    cidr_block              = var.subnet_4_cidr
    availability_zone       = "us-east-1d"
    map_public_ip_on_launch = true
    tags = {
        app  = "move"
        name = "move-subnet-4"
    }
    depends_on = [
        aws_vpc.move_vpc
    ]
}

# Creación del Internet gateway
resource "aws_internet_gateway" "move_internet_gateway" {
  vpc_id = aws_vpc.move_vpc.id
  tags = {
    app  = "move"
    Name = "move-internet-gateway"
  }
}

# Creación de una tabla de enrutamiento
resource "aws_route_table" "move_route_table" {
  vpc_id = aws_vpc.move_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.move_internet_gateway.id
  }
  tags = {
    app  = "move"
    Name = "move-route-table"
  }
  depends_on = [
    aws_internet_gateway.move_internet_gateway
  ]
}

# Asociación de la tabla de enrutamiento a la VPC
resource "aws_main_route_table_association" "move_tabla_enrutamiento_vpc" {
    route_table_id = aws_route_table.move_route_table.id
    vpc_id = aws_vpc.move_vpc.id
}

# Creación del grupo de seguridad
resource "aws_security_group" "move_security_group" {
    name = "move_security_group"
    vpc_id = aws_vpc.move_vpc.id
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        app  = "move"
        Name = "move_security_group"
    }
}

# Creación de instancias
resource "aws_instance" "move-ms-security" {
    count         = 2
    ami           = var.ami_microservice
    instance_type = var.ec2_instance_type
    subnet_id     = aws_subnet.move_subnet1.id
    key_name      = "move-keypair"
    security_groups = [aws_security_group.move_security_group.id]
    user_data = "${file("scripts/user-data-ms-move-security.sh")}"
    tags = {
        Name = "move-ms-security-${count.index + 1}"
    }
}
resource "aws_instance" "move-ms-admin" {
    count         = 2
    ami           = var.ami_microservice
    instance_type = var.ec2_instance_type
    subnet_id     = aws_subnet.move_subnet2.id
    key_name      = "move-keypair"
    security_groups = [aws_security_group.move_security_group.id]
    user_data = "${file("scripts/user-data-ms-move-admin.sh")}"
    tags = {
        Name = "move-ms-admin-${count.index + 1}"
    }
}
resource "aws_instance" "move-ms-trip" {
    count         = 2
    ami           = var.ami_microservice
    instance_type = var.ec2_instance_type
    subnet_id     = aws_subnet.move_subnet3.id
    key_name      = "move-keypair"
    security_groups = [aws_security_group.move_security_group.id]
    user_data = "${file("scripts/user-data-ms-move-trip.sh")}"
    tags = {
        Name = "move-ms-trip-${count.index + 1}"
    }
}