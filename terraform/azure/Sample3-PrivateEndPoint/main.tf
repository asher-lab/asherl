// Data is used when you created an existing resource and try to reference it later.



module "vnet"{
    source = "./Module/vnet"
}
module "vm_public"{
    source = "./Module/vm_public"
    subnet_ids = module.vnet.subnet_ids
    nsg_ids = module.vnet.nsg_ids
}
module "vm_private"{
    source = "./Module/vm_private"
    subnet_ids = module.vnet.subnet_ids
    nsg_ids = module.vnet.nsg_ids
}
module "sql-private-endpoint"{
    source = "./Module/sql_private_endpoint"
    subnet_ids = module.vnet.subnet_ids
}
module "sql-normal"{
    source = "./Module/sql_normal"
    subnet_ids = module.vnet.subnet_ids
}
