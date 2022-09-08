# fonte https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

# Recurso que cria um security group
resource "aws_security_group" "acesso_ssh" {   # define o recurso
  name        = "acesso_ssh"                   # nome para nossa security_group
  description = "acesso_ssh"                   # descrição da nossa security_group
  

  ingress {
    description      = "tcp_ssh"      
    from_port        = 22                    # porta de saída
    to_port          = 22                    # posta de entrada
    protocol         = "tcp"                 # tipo de conexão
    cidr_blocks      = var.cdirs_acesso_remoto  # ips que podem ter acesso
    
  }

  tags = {
    Name = "allow_tls"   # Nome do nosso recurso 
  }
}



resource "aws_security_group" "acesso_ssh_us-east-2" {   # define o recurso
  provider   = aws.us-east-2                # sefinimos o provedor passando seu alias
  name        = "acesso_ssh"                   # nome para nossa security_group
  description = "acesso_ssh"                   # descrição da nossa security_group
  

  ingress {
    description      = "tcp_ssh"      
    from_port        = 22                       # porta de saída
    to_port          = 22                       # posta de entrada
    protocol         = "tcp"                    # tipo de conexão
    cidr_blocks      = var.cdirs_acesso_remoto  # ips que podem ter acesso
    
  }

  tags = {
    Name = "allow_tls"   # Nome do nosso recurso 
  }
}
