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

Then, install extention Terraform in VSCode for terraform language.

## Section 3

### Terraform Hello World

Scope -> author (write config file) + Initialize -> plan -> apply.

Local provider -> Local file (write content and create files).

```hcl
# main.tf
resource local_file sample_res {
  filename = "sample.txt"
  content = "I love terraform!"}
```

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

**Arguments**:

Do the same, but with changing argument.

```hcl
# main.tf
resource local_file sample_res {
  filename = "sample_args.txt"
  sensitive_content = "I love terraform!"
}
```

**Multiple resources**:

Multiple resources in a single file.

```hcl
resource local_file cat_res {
  filename = "cat.txt"
  sensitive_content = "I love cats!"
}

resource local_file dog_res {
  filename = "dog.txt"
  sensitive_content = "I love dogs!"
}
```

**Random provider**:

So far, we saw one single provider to write file with content.

Random provider introduces randomness, ID generation, random string etc. It is a logical provider. random provider has random_id random_integer etc.

```hcl
resource random_integer rint {
  min = 100
  max = 200
}

# like print statement
output name1 {
  value = random_integer.rint.result
}
```

Do same for string.

```hcl
resource random_string rstring {
    length = 20
}

# like print statement
output name1 {
  value = random_string.rstring.result
}
```

**Variables**:

Use variable to define config file.

```
# main.tf
resource local_file sample_res {
  filename = var.filename
  sensitive_content = var.content
}
```

```
# variables.tf
variable filename {
  type = string
  default = "sample.txt"
}

variable content {
  type = string
  default = "I am loving terraform!"
}
```

It destroys old resource and creates new one for us!

**Other variables**:

```
# main.tf
resource local_file sample_res {
  filename = var.filename1
  #sensitive_content = var.content1[0] # for lists
  sensitive_content = var.content1["name"] # for maps
}


# variables.tf
variable filename1 {
  type = string
  default = "sample1.txt"
}

/*
variable content1 {
  type = number
  default = 23
}
*/

/*
variable content1 {
  type = bool
  default = true
}
*/

/*
variable content1 {
  type = list(string)
  default = ["red", "green", "blue"]
}
*/

/*
variable content1 {
  type = tuple([string,bool,number])
  default = ["red", true, 23]
}
*/

variable content1 {
  type = map
  default = {name = "Hasib", age = 29}
}
```

Naming conventions: terraform.tfvars, terraform.tfvars.json etc.

**Multiple Providers**:

Two providers in one single file.

```
# main.tf
resource local_file sample_res {
  filename = "sample.txt"
  content = "This is HCL."
}

resource random_string name {
    length = 10
}
```

Now, how to put resource from another provider into content. Other resource attribute in another resource.

```
# Implicit
resource local_file name1 {
  filename = "implicit.txt"
  content = "This is random string from RP : ${random_string.name2.id}"
}

resource random_string name2 {
    length = 10
}
```

```
# Explicit
resource local_file name1 {
  filename = "explicit.txt"
  content = "This is random string from RP : ${random_string.name2.id}"
  depends_on = [random_string.name2]
}

resource random_string name2 {
    length = 10
}
```

**Output Blocks**:

```
# main.tf
resource random_string rand_name {
    length = 10
}

# output.tf
output name {
  value       = random_string.rand_name.id
}
```

**Lifecycle rules**:

- create before destry
- prevent destroy
- ignore changes

```
# main.tf
resource random_integer name {
  min = 20
  max = 350

    lifecycle{
        #create_before_destroy = true
        #prevent_destroy = true
        ignore_changes = [min]
    }
}
```

**Provider version**:

```
# main.tf
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "2.3.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource random_integer name {
  min = 0
  max = 100
}
```

**Data source**:

```
# main.tf

# read file
data local_file name {
  filename = "sample1.txt"
}

# print
output name1 {
  value = data.local_file.name.content
}
```

### Section 4

**Terraform with GCP**:

Create new project and service account.

**Google cloud provider**:

So far we saw,

- L, read files
- R, generate randomness

https://registry.terraform.io/providers/hashicorp/google/latest/docs 

**Connect with GCP**:

1. Username/password
2. Google cloud vm
3. Service account keys

Create a gcp bucket.

Install HashiCorp Terraform extension on VSCode.

**Connect with GCP Way 1**:

From local machine how to autheticate with gcp to create new resource. See `gcp/get-started-gcp/` folder.

```
# main.tf
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.80.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "deployment-stuff"
  region = "us-central1"
  zone = "us-central1-a"
}

resource google_storage_bucket "default" {
  name = "bucket-from-tf-hasibzunair-121233"
  location      = "US"
  storage_class = "STANDARD"
}
```

Run `gcloud auth application-default login` to autheticate. Then run`main.tf`, it will create a new bucket in gcp!

**Connect with GCP Way 2**:

Inside gcp, how to autheticate with gcp to create new resource.

1. Open cloud shell.
2. Run previous main.tf
3. A new bucket will be created!

**Connect with GCP Way 3**:

Autheticate with service account.

1. Go to IAM > Service Accounts > Create a service acc (terraform-gcp@deployment-stuff.iam.gserviceaccount.com)
2. Manage keys, create key, JSON, download file
3. Grant access to service account for Storage access to create resources (terraform-gcp@deployment-stuff.iam.gserviceaccount.com).
4. Run

```
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.80.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "deployment-stuff"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "keys.json" # new arg added
}

resource google_storage_bucket "default" {
  name = "bucket-from-tf-hasibzunair-121233-with-service-acc"
  location      = "US"
  storage_class = "STANDARD"
}
```

Then terraform init, plan and apply! You will see new bucket.

**Resource Provision**:

How to provision different services and resources inside GCP.

In next videos, we will see how what resource does, how to provision them using cloud console and terraform scripts.

1. What resource does?
2. Cloud console provisioning?
3. Terraform script with minimum attributes
4. More arguments

### Section 5

**Google Cloud Storage with Terraform**:

1. Make three files, keys.json, provider.tf and main.tf
2. Hit CTRL + Space to get suggestions.
3. See gcs-with-terraform folder.

Make a bucket and upload object using Terraform.

### Section 6

