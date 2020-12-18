#Arquivo que chama módulos filhos
module "servers" {
    source = "./servers"
    servers = 1
}

output "public_dns-us-east-1" { 
  value = module.servers.public_dns
}