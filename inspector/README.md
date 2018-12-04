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

aws_instance.inspector (remote-exec): AWS Customer Agreement or other agreement with Amazon Web Services, Inc. or its affiliates governing your
aws_instance.inspector (remote-exec): use of AWS services. You may not install and use the Amazon Inspector Agent unless you have an account in
aws_instance.inspector (remote-exec): good standing with AWS.
aws_instance.inspector (remote-exec): *  *  *
aws_instance.inspector (remote-exec): Current running agent reports to arsenal endpoint:
aws_instance.inspector (remote-exec): Current running agent reports version as: 1.1.933.0
aws_instance.inspector (remote-exec): This install script was created to install agent version:1.1.933.0
aws_instance.inspector (remote-exec): In most cases, these version numbers should be the same.

aws_instance.inspector: Creation complete after 1m3s (ID: i-0fc57e8dc63ee9e88)

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

```

##### Step 5 :

* * Open AWS console on the browser and go to `AWS Inspector page` and click the `Assessment templates` and select all and click `Run` button

##### Step 6 :
 
 * Run `terraform destroy` to remove services related to AWS Inspector from AWS.
 
    1. It will ask you to enter **Region**
    2. It will ask permission to do the actions type `yes` and press enter to continue 


```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/inspector/lab# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

random_string.random_name: Refreshing state... (ID: none)
tls_private_key.inspector_key: Refreshing state... (ID: f50c04f5649a8c8e2c995a19e63cc07e11ea4280)
local_file.aws_key: Refreshing state... (ID: e927a60f6a0701be682a1dbfd273b166facb868c)
  - local_file.aws_key

  - random_string.random_name

  - tls_private_key.inspector_key


Plan: 0 to add, 0 to change, 9 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

local_file.aws_key: Destroying... (ID: e927a60f6a0701be682a1dbfd273b166facb868c)
local_file.aws_key: Destruction complete after 0s
aws_inspector_assessment_template.test-template: Destroying... (ID: arn:aws:inspector:us-east-1:358174707935:target/0-x4SjyrUY/template/0-SZ9cbPbl)
aws_instance.inspector: Destroying... (ID: i-0fc57e8dc63ee9e88)
aws_inspector_assessment_template.test-template: Destruction complete after 1s
aws_inspector_assessment_target.test-target: Destroying... (ID: arn:aws:inspector:us-east-1:358174707935:target/0-x4SjyrUY)
aws_inspector_assessment_target.test-target: Destruction complete after 1s
aws_inspector_resource_group.test-group: Destroying... (ID: arn:aws:inspect

aws_key_pair.generated_key: Destruction complete after 1s
tls_private_key.inspector_key: Destroying... (ID: f50c04f5649a8c8e2c995a19e63cc07e11ea4280)
tls_private_key.inspector_key: Destruction complete after 0s
aws_security_group.allow_ssh: Destruction complete after 2s
random_string.random_name: Destroying... (ID: none)
random_string.random_name: Destruction complete after 0s

Destroy complete! Resources: 9 destroyed.


```
