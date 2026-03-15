# 🌍 Terraform DevOps Project – Building a Cloud City ☁️🏙️

Welcome to this Terraform repository!

Imagine AWS is an **empty island** 🏝️.  
Our mission is to build a **fully functional cloud city** for our Todo App.

Instead of constructing everything manually, we use **Terraform Infrastructure as Code (IaC)** to automatically build the entire environment.

Think of Terraform like a **city architect** 📐.

You describe the city once, and Terraform builds it exactly the same way every time.

---

# 🧭 What This Project Builds

This Terraform project automatically creates the infrastructure required for a **Kubernetes based Todo Application**.

The infrastructure includes:

🌐 VPC Network  
🚪 Internet Gateway  
🚦 NAT Gateway  
🔐 IAM Roles  
☸️ EKS Kubernetes Cluster  
⚙️ Worker Node Groups  

All built automatically using **Terraform Modules**.

---

# 🏗 Cloud Architecture

Below is the simplified architecture of what Terraform creates.

```
                🌍 Internet
                    │
                    ▼
           ┌───────────────────┐
           │  Internet Gateway │
           └─────────┬─────────┘
                     │
             🌐 Public Subnets
               │          │
               ▼          ▼
         NAT Gateway   NAT Gateway
               │
               ▼
          🔒 Private Subnets
               │
               ▼
        ☸️ EKS Kubernetes Cluster
               │
               ▼
        ⚙️ Worker Node Group
               │
               ▼
         🐳 Application Pods
```

Result:

Users → Internet → AWS → Kubernetes → Application 🚀

---

# 📂 Repository Structure

The project structure is organized like a **well-planned city map** 🗺️.

```
project
│
├── backend
│   ├── backend.tf
│   ├── main.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variable.tf
│
└── modules
    ├── vpc
    ├── NATGW
    ├── IAM
    ├── EKS
    ├── NODEGRP
    └── key
```

Each module is like a **specialized construction team** 🧑‍🔧.

Example:

| Module | Responsibility |
|------|------|
| VPC | Builds the network |
| NATGW | Provides internet access to private networks |
| IAM | Creates access roles and permissions |
| EKS | Creates Kubernetes cluster |
| NODEGRP | Creates worker nodes |
| key | SSH key infrastructure |

---

# 🧠 Terraform Backend (Remote State)

File:

```
backend/backend.tf
```

This configures **remote state storage**.

```hcl
terraform {
  backend "s3" {
    bucket = "Enter-bucket-name"
    key    = "backend/ToDo-App.tfstate"
    region = "ap-south-1"
    dynamodb_table = "Enter-table-name"
  }
}
```

### Why Remote State?

Terraform needs a **memory file** to remember what infrastructure exists.

This file is called:

```
terraform.tfstate
```

Instead of storing it locally, we store it in:

📦 **S3 Bucket** → stores state  
🔒 **DynamoDB Table** → prevents multiple engineers from modifying state at the same time

Result:

Team collaboration without chaos 🎉

---

# 🌐 Provider Configuration

File:

```
provider.tf
```

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

This tells Terraform:

> "Hey Terraform, build everything in **AWS Mumbai region**."

---

# ⚙️ Terraform Variables

File:

```
terraform.tfvars
```

Example configuration:

```hcl
REGION = "ap-south-1"
DEVOPS_PROJ = "TODO-APP"

VPC_CIDR = "10.0.0.0/16"

PUBLIC_CIDR_SUB1 = "10.0.1.0/24"
PUBLIC_CIDR_SUB2 = "10.0.2.0/24"

PRI_CIDR_SUB1 = "10.0.3.0/24"
PRI_CIDR_SUB2 = "10.0.4.0/24"
```

Think of these like **ingredients for our cloud recipe** 🍳.

---

# 🏗 Infrastructure Modules

Terraform modules are like **reusable infrastructure building blocks** 🧱.

Instead of writing everything in one file, we organize infrastructure into logical modules.

---

# 🌐 VPC Module

Creates the **network foundation**.

Responsibilities:

✔ VPC  
✔ Public Subnets  
✔ Private Subnets  
✔ Internet Gateway  

Without this module, nothing in AWS can communicate.

---

# 🚦 NAT Gateway Module

This module allows **private servers to access the internet securely**.

Example:

```
Private EC2 → NAT Gateway → Internet
```

But the internet **cannot access them directly**.

This improves security 🔐.

---

# 🔐 IAM Module

Creates the required **AWS Identity and Access Management roles**.

These roles allow services like EKS to interact with other AWS resources.

Example roles created:

✔ EKS Cluster Role  
✔ Node Group Role  

Think of IAM roles like **ID cards for AWS services** 🪪.

---

# ☸️ EKS Module

This module creates the **Amazon EKS Kubernetes cluster**.

Responsibilities:

✔ Control Plane  
✔ Kubernetes API Server  
✔ Networking integration with VPC  

Result:

A fully managed **Kubernetes control plane**.

---

# ⚙️ Node Group Module

Creates the **worker nodes** for the Kubernetes cluster.

Worker nodes are basically **EC2 machines where containers run**.

Flow:

```
Kubernetes Cluster
      │
      ▼
Worker Nodes
      │
      ▼
Application Pods
```

---

# 🧩 Terraform Module Connection

All modules are connected in `main.tf`.

Example flow:

```
VPC
 │
 ▼
NAT Gateway
 │
 ▼
IAM Roles
 │
 ▼
EKS Cluster
 │
 ▼
Node Groups
```

Terraform builds them in the correct order automatically.

---

# 🚀 Terraform Workflow

Running this infrastructure requires just a few commands.

### Initialize Terraform

```
terraform init
```

Downloads providers and prepares the workspace.

---

### Validate configuration

```
terraform validate
```

Checks if the Terraform configuration is correct.

---

### Preview infrastructure

```
terraform plan
```

Shows what Terraform **will create before actually creating it**.

---

### Deploy infrastructure

```
terraform apply
```

Terraform now **builds the entire infrastructure automatically**.

Sit back and enjoy the automation ☕.

---

# 🧠 Concepts Demonstrated

This project demonstrates modern DevOps infrastructure practices:

✔ Infrastructure as Code (Terraform)  
✔ Modular Terraform Architecture  
✔ AWS VPC Networking  
✔ Kubernetes Cluster Provisioning (EKS)  
✔ IAM Role Management  
✔ Secure Remote Terraform State  
✔ Highly Available Cloud Infrastructure  

---

# 🎯 Why This Project Matters

This repository represents a **real-world DevOps infrastructure setup** used for deploying containerized applications.

Key highlights:

🚀 Fully automated infrastructure  
🔁 Modular reusable Terraform design  
☸️ Kubernetes ready environment  
🔒 Secure state management  

---

# 👨‍💻 Author

Mahesh Avula  
Cloud / DevOps Engineer

Passionate about building **cloud infrastructure, Kubernetes platforms, and automated CI/CD pipelines** ☁️⚙️
