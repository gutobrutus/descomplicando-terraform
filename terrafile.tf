#Arquivo que chama módulos filhos
module "servers" {
  source         = "./servers"
  qtde_instances = 1
}

output "public_dns-us-east-1" {
  value = module.servers.public_dns
}