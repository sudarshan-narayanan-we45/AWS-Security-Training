## AWS Security Group

>A security group acts as a virtual firewall for your instance to control inbound and outbound traffic. When you launch an instance in a VPC, you can assign up to five security groups to the instance. Security groups act at the instance level, not the subnet level. Therefore, each instance in a subnet in your VPC could be assigned to a different set of security groups. If you don't specify a particular group at launch time, the instance is automatically assigned to the default security group for the VPC.

For each security group, you add rules that control the inbound traffic to instances, and a separate set of rules that control the outbound traffic. This section describes the basic things you need to know about security groups for your VPC and their rules. 


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  ` /home/vagrant/Desktop/Labs/AWS-Security-Training/security_group/lab`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/security_group/lab
    ```
##### Step 3:

* Run `terraform apply`

* **Note:**
 
1. It will ask you to enter `key name` give any name you like, using same key we can ssh into the ec2 server.

2. It will ask you permissions to perform actions like (`Do you want to perform these actions?`). Type `yes` and press `enter` it will continues the rest of the actions.


```commandline
terraform apply

var.key_name
  Enter a value:ucsf_ec2_instance

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_vpc.ucsf-vpc
      id:                               <computed>
      arn:                              <computed>
      assign_generated_ipv6_cidr_block: "false"
      cidr_block:                       "10.0.0.0/16"


Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
  
  
aws_vpc.ucsf-vpc: Creating...
  arn:                              "" => "<computed>"

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
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
