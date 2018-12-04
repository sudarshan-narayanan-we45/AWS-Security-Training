## Amazon KMS

>


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/kms/grant_token/lab`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/kms/grant_token/lab
    ```

##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/grant_token/lab# terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.50.0)...
- Downloading plugin for provider "random" (2.0.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.50"
* provider.random: version = "~> 2.0"

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
    
````commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/grant_token/lab# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_iam_user.testuser
      id:                                                          <computed>
      arn:                                                         <computed>
      force_destroy:                                               "false"
      name:                                                        "${random_string.username.result}-user"
      path:                                                        "/"
      unique_id:                                                   <computed>
 special:                                                     "false"
      upper:                                                       "false"


Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.username: Creating...
  length:      "" => "10"
  lower:       "" => "true"
  min_lower:   "" => "0"
  min_numeric: "" => "0"
  min_special: "" => "0"
  min_upper:   "" => "0"
  number:      "" => "true"
  result:      "" => "<computed>"
  special:     "" => "false"
  upper:       "" => "false"

  operations.3592719599:                                       "" => "GenerateDataKey"
  retire_on_delete:                                            "" => "false"
aws_kms_grant.hugh-grant: Creation complete after 2s (ID: bd8cb949-b104-470e-a8df-0006390e9751:c2...cc2f9d9ceabbb293f2d9c17bc0133691bb4fbc)

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

````

##### Step 5:

* Run `terraform destroy` to remove services related to KMS from AWS.

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue


```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/grant_token/lab# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

random_string.username: Refreshing state... (ID: none)
  - aws_kms_key.grant_key

  - random_string.username


Plan: 0 to add, 0 to change, 4 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_kms_grant.hugh-grant: Destroying... (ID: bd8cb949-b104-470e-a8df-0006390e9751:c2...cc2f9d9ceabbb293f2d9c17bc0133691bb4fbc)
aws_kms_grant.hugh-grant: Destruction complete after 2s
aws_kms_key.grant_key: Destroying... (ID: bd8cb949-b104-470e-a8df-0006390e9751)
aws_iam_user.testuser: Destroying... (ID: n462qoymkw-user)
random_string.username: Destruction complete after 0s
aws_kms_key.grant_key: Still destroying... (ID: bd8cb949-b104-470e-a8df-0006390e9751, 10s elapsed)
aws_kms_key.grant_key: Still destroying... (ID: bd8cb949-b104-470e-a8df-0006390e9751, 20s elapsed)
aws_kms_key.grant_key: Destruction complete after 28s

Destroy complete! Resources: 4 destroyed.


```
