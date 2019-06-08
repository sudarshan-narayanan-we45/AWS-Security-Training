## AWS Security Group

>A security group acts as a virtual firewall for your instance to control inbound and outbound traffic. When you launch an instance in a VPC, you can assign up to five security groups to the instance. Security groups act at the instance level, not the subnet level. Therefore, each instance in a subnet in your VPC could be assigned to a different set of security groups. If you don't specify a particular group at launch time, the instance is automatically assigned to the default security group for the VPC.

For each security group, you add rules that control the inbound traffic to instances, and a separate set of rules that control the outbound traffic. This section describes the basic things you need to know about security groups for your VPC and their rules. 


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/we45/AWS-Security-Training/security_group/lab`

    ```commandline
    cd  /home/we45/AWS-Security-Training/security_group/lab
    ```
##### Step 3:

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/security_group/lab# terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "random" (2.0.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.49"
* provider.random: version = "~> 2.0"
* provider.tls: version = "~> 1.2"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```

##### Step 4:

* Run `terraform apply`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue

```commandline

```

##### Step 4 :

* Open AWS console on the browser, check the created `EC2` instance(s) and check security group 

##### Step 5 :
 
 * Run `terraform destroy` to remove EC2 and Security Group from AWS.
 
 **Note:** It will ask your permission to destroy the created EC2 from AWS (`Do you really want to destroy all resources?`). Type 'yes' then press `enter`
 to continue the process. 
 
 ```commandline
 
    Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
  aws_flow_log.ucsf_aws_vpc_flow_log: Destroying... (ID: fl-0213b696e3b6c5c4e)
  aws_iam_role_policy.ucsf_vpc_flow_log_iam_policy: Destroying... (ID: ucsf_flowlogsRole:ucsf_flowlogsRolePolicy)
  aws_iam_role_policy.ucsf_vpc_flow_log_iam_policy: Destruction complete after 1s
  aws_flow_log.ucsf_aws_vpc_flow_log: Destruction complete after 4s
  aws_iam_role.vpc_flow_iam_role: Destroying... (ID: ucsf_flowlogsRole)
  aws_cloudwatch_log_group.vpc_flow_cloud_watch_group: Destroying... (ID: ucsf-aws-vpc-flow-log)
  aws_vpc.ucsf-vpc: Destroying... (ID: vpc-0abd67f8f4ffe1199)
  aws_cloudwatch_log_group.vpc_flow_cloud_watch_group: Destruction complete after 2s
  aws_vpc.ucsf-vpc: Destruction complete after 2s
  aws_iam_role.vpc_flow_iam_role: Destruction complete after 2s

  Destroy complete! Resources: 5 destroyed.
```
