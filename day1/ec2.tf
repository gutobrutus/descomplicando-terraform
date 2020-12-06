resource "aws_instance" "web" {
  ami           = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"

  tags = {
    treinamento = "linuxtips",
    curso = "descomplicando-terraform"
  }
}