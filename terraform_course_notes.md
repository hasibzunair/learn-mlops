# Terraform for Beginners using GCP - Google Cloud (Hands-on) Notes

Course Link - [Link](https://www.udemy.com/course/terraform-for-beginners-using-google-cloud/).

## Section 1

Intro.

## Section 2

Infrastructure as code.

Traditional IT: Business requiremnt -> Technical details -> Tech lead (infra design) -> Get onprem hardware -> Infra team (provision hardware) -> Dev start working on application. (This is slow and expensive to scale!)

Enter Public Cloud (AWS, GCP, Azure).

Resource provisioning, cloud provider manages everything.

Interact with cloud: Cloud console/portal, VM provisions, if thousands of VMs then use APIs.

Different teams write diff scripts for resource provisioning. No unique approach. Recreate wheel :(

Enter Docker, Puppet, Ansible, **Terraform**, Packer!

**Terraform is used for infrastructure provisioning inside the cloud**. Infrastructure as code.

Infrastructure as Code (IAC): Create python script for VM, maintaining such code is tedious task.

Write code with **HCL** that manages everything.

**Terraform**:

- Infrastructure provisioning
- HCL language
- Binary file
- AWS, GCP, Azure
- Agentless tool
- Idempotent (Python script -> VM -> 3 resources -> cost three time). With terraform, creae VM, run 3 times, only 1 resource will be created, not 3.
- Native tool
- Cloud agnostic

**Installation**:

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## Section 3

### Terraform Hello World

Scope -> author (write config file) + Initialize -> plan -> apply

**Scope and Author:**

- Scope and author: Create local file, sample.txt with some content
- Write config file in HCL
- see helloworld/main.tf

**Initialize -> plan -> apply:**

init

- first command after writing config file (go to `main.tf` and run `terraform init`)
- init a working dir
- download pluging

plan

- create exect plan (run `terraform plan` cmd in shell.)
- doesnt change infra

apply  

- execute all change and provision resource specified in config files (`terraform apply`)
