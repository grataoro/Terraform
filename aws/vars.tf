variable "amis" {      # Dá um nome para nossas variáveis 
  type = map(string)   # Define um tipo para nossas variáveis 

  default = {         # Variáveis no estilo chave valor 

       "us-east-1" = "ami-052efd3df9dad4825"       
       "us-east-2" = "ami-092b43193629811af"

  }
}



variable "cdirs_acesso_remoto" {      # Dá um nome para nossa variáve 
  type = list(string)                 # Define o tipo da nossa variável 

  default = ["177.30.99.177/32","177.30.99.177/32"] # Variáveis no estilo lista

}

variable "key_name" {
  type = string

  default = "terraform"  

}