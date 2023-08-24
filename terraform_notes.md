# GCP Fundamentals for Beginners Notes

Course Link - [Link](https://concordia.udemy.com/course/terraform-for-beginners-using-google-cloud/learn/).

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