## Amazon Inspector

>Amazon Inspector is an automated security assessment 
service that helps improve the security and compliance of 
applications deployed on AWS. Amazon Inspector automatically 
assesses applications for exposure, vulnerabilities, 
and deviations from best practices.


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  ` /home/vagrant/Desktop/Labs/AWS-Security-Training/inspector/lab`

```commandline
cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/inspector/lab
```
##### Step 3:

* Run `terraform init`

    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/inspector/lab# terraform init
    
    Initializing provider plugins...
    
    The following providers do not have any version constraints in configuration,
    so the latest version was installed.
    
    To prevent automatic upgrades to new major versions that may contain breaking
    changes, it is recommended to add version = "..." constraints to the
    corresponding provider blocks in configuration, with the constraint strings
    suggested below.
    
    * provider.aws: version = "~> 1.49"
    * provider.local: version = "~> 1.1"
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
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/inspector/lab# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 
  
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_inspector_assessment_target.test-target
      id:                                    <computed>
      arn:                                   <computed>
      name:                                  "inspector-assessment"
      resource_group_arn:                    "${aws_inspector_resource_group.test-group.arn}"

  + aws_inspector_assessment_template.test-template
      id:                                    <computed>
      arn:                                   <computed>
      duration:                              "3600"
      name:                                  "test-template"
      rules_package_arns.#:                  "1"
      rules_package_arns.2467963249:         "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-PmNV0Tcd"
      target_arn:                            "${aws_inspector_assessment_target.test-target.arn}"

  + aws_inspector_resource_group.test-group
      id:                                    <computed>
      arn:                                   <computed>
      tags.%:                                "2"
      tags.Env:                              "test-group"
      tags.Name:                             "aws-inspector-instance"

Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

tls_private_key.inspector_key: Creating...
  algorithm:                  "" => "RSA"
  ecdsa_curve:                "" => "P224"
  private_key_pem:            "" => "<computed>"
  public_key_fingerprint_md5: "" => "<computed>"
  public_key_openssh:         "" => "<computed>"
  public_key_pem:             "" => "<computed>"
  rsa_bits:                   "" => "4096"

```

##### Step 4 :

* Need to write

##### Step 5 :
 
 * Run `terraform destroy` to remove the EC2 and Inspector from the AWS.
 * **Note:** It will ask for your permission to destroy the created EC2 and Inspector from AWS (`Do you really want to destroy all resources?`). Type 'yes' then press `enter` to continue the process. 
  
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
