
terraform {
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
}


provider "aws" {         # Tipo deo provedor 
  region = "us-east-1"   # região 
}

resource "aws_instance" "dev" {       # nome do recurso 
    count = 3                         # quantidade de maquinas
    ami = "ami-052efd3df9dad4825"     # imagem ami da maquina
    instance_type = "t2.micro"        # tipo de maquina 
    key_name = "terraform"        # nome do par de chaves
    tags = {                          # tags
        Name = "dev${count.index}"    # count.index faz referência ao numero da maquina                                   
    }
    vpc_security_group_ids = ["sg-06f4244ba70dc2430"] # define o security group para as maquinas 
}

# fonte https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "acesso_ssh" {   # define o recurso
  name        = "acesso_ssh"                   # nome para nossa security_group
  description = "acesso_ssh"                   # descrição da nossa security_group
  

  ingress {
    description      = "tcp_ssh"      
    from_port        = 22                    # porta de saída
    to_port          = 22                    # posta de entrada
    protocol         = "tcp"                 # tipo de conexão
    cidr_blocks      = ["177.30.99.177/32"]  # ips que podem ter acesso
    
  }

  tags = {
    Name = "allow_tls"   # Nome do nosso recurso 
  }
}