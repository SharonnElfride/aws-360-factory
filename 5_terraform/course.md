## Terraform

Open Source with Mitchell Hashimoto from HashiCorp <br />
Bootstrapping tool for creation, updating, deleting the infrastructure <br />
Files in HCL (Hashicorp Configuration Language) - can be converted to JSON <br />
For Cloud infrastructure and is InfraAsCode <br />
Infrastructure description <br />
Can help see the modifications

> Providers: AWS, DigitalOcean, GCP, Azure

> Other products from HashiCorp => Vagrant, Vault(keys)

- Terraform Commands
  - terraform init (specify the provider - keys (if needed) + region -)
  - terraform apply ()
  - terraform destroy (destroy everything)
- Terraform Concepts
  - resources (write)
  - data (read-only)
  - variables
  - outputs
- Terraform infrastructure
  - main.tf (resources)
  - datasources.tf (datasources)
  - variables.tf
  - interpolations.tf
  - output.tf (return values)
- Terraform Others
  - for & for_each
- Terraform State file 
  - terraform.tfstate in JSON **<span style="color: red">(DO NOT LOSE, DO NOT MODIFY)</span>**
  - Do a remote terraform.tfstate 
  - Must be protected by a semaphore/mutex

#### **Shared resources (critical resources) => Must be protected by a semaphore/mutex**

Terraform execution is based on graph theory <br />
Create "stuff" in parallel if no dependence injection. Either way, it creates the dependencies first, then the "children" <br />
DAG => Directed Acyclic Graph with directions and arrows

#### **If you comment your code and run <u>*terraform apply*</u>, everything will be destroyed !**

> **+** before a line => resources creation <br />
> **~** ... => resources modification <br />
> **+/-** ... => resources recreation <br />
> **-** ... => resources destruction <br />


