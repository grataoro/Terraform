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

provider "aws" {         # Tipo deo provedor 
  alias = "us-east-2"
  region = "us-east-2"   # região 
}


# recurso que cria 3 maquinas EC2
resource "aws_instance" "dev" {       # nome do recurso 
    count = 3                         # quantidade de maquinas
    ami = var.amis["us-east-1"]    # imagem ami da maquina
    instance_type = "t2.micro"        # tipo de maquina 
    key_name = var.key_name            # nome do par de chaves
    tags = {                          # tags
        Name = "dev${count.index}"    # count.index faz referência ao numero da maquina                                   
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"] # define o security group para as maquinas 
}




# recurso que cria uma maquinas EC2
resource "aws_instance" "dev4" {       # nome do recurso 
    ami = var.amis["us-east-1"]     # imagem ami da maquina
    instance_type = "t2.micro"        # tipo de maquina 
    key_name = var.key_name         # nome do par de chaves
    tags = {                          # tags
        Name = "dev4"    # count.index faz referência ao numero da maquina                                   
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"] # define o security group para as maquinas 
    depends_on = [aws_s3_bucket.dev4]
}

# recurso que cria uma maquinas EC2 na região us-east-2
resource "aws_instance" "dev5" {       # nome do recurso 
    provider = aws.us-east-2     # definimos o provedor passando seu alias
    ami = var.amis["us-east-2"]      # imagem ami da maquina
    instance_type = "t2.micro"        # tipo de maquina 
    key_name = var.key_name         # nome do par de chaves
    tags = {                          # tags
        Name = "dev5"    # count.index faz referência ao numero da maquina                                   
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh_us-east-2.id}"] # define o security group para as maquinas 
    depends_on = [aws_dynamodb_table.dynamodb-homologacao]
}


# recurso que cria um buckets no S3
# fonte https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "dev4" {
  bucket = "save-dev4"
  acl    = "private"

  tags = {
    Name        = "save-dev4"
    # Environment = "Dev"
  }
}


resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = aws.us-east-2
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
} 