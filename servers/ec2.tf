#us-east-1
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] #Ubuntu
}

resource "aws_instance" "web" {
  #count         = var.environment == "production" ? 2 + var.plus : 1
  #count         = var.production ? 2 : 1
  ami           = data.aws_ami.ubuntu.id
  #instance_type = count.index < 1 ? "t2.micro" : "t3.medium"
  for_each = {
    dev = "t2.micro"
    staging = "t3.medium"
  }
  instance_type = each.value
  tags = {
    Name        = "web"
    treinamento = "linuxtips"
    curso       = "descomplicando-terraform"
    Env         = each.key
  }
}

/*resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name        = "web2"
    treinamento = "linuxtips"
    curso       = "descomplicando-terraform"
  }
  depends_on = [aws_instance.web] #dependencia explícita
}*/

#dependência implícita
/*resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.web[0].id
}*/