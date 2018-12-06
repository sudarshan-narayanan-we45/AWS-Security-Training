## Amazon KMS

>


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/kms/simple_encrypt/lab`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/kms/simple_encrypt/lab
    ```

##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/simple_encrypt/lab# terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.50.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.50"

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
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/simple_encrypt/lab# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

 <= data.aws_kms_ciphertext.oauth
      id:                  <computed>
      ciphertext_blob:     <computed>
      key_id:              "${aws_kms_key.oauth_config.key_id}"
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_kms_key.oauth_config: Creating...
  arn:                 "" => "<computed>"
  description:         "" => "oauth config"
  enable_key_rotation: "" => "true"
  is_enabled:          "" => "true"
  key_id:              "" => "<computed>"
  key_usage:           "" => "<computed>"
  policy:              "" => "<computed>"
  tags.%:              "" => "1"
  tags.Name:           "" => "OAuth Key"
aws_kms_key.oauth_config: Still creating... (10s elapsed)
aws_kms_key.oauth_config: Creation complete after 17s (ID: 4e78c7a7-8fdc-46ee-9db2-fcbf224afe0d)
data.aws_kms_ciphertext.oauth: Refreshing state...

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

ciphertext = AQICAHjJVx96MDjRjp5ECGelTx5BbtE0+hGSgfHiVYvX3haqoAH40fOn/G9EkFHtIasLEx2MAAAAzDCByQYJKoZIhvcNAQcGoIG7MIG4AgEAMIGyBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDPEAmjamxHxtmfmEcgIBEICBhHgJ0oaILtwMzw93PP9Y3UNqJO7BLu7sdyltoKiF4vZDatWdr/uGIu8i3j77rmtuGnoA7tCR7xlpGe+xrWUECUaKY4AoWa5DQeMqcF1EG+JQbxwR2KH7bGvu1ViQMhbA1WUPUIF9G4thLi5GsF5qM5BPueXhvUDkr/8N6DiT8zkNzqudPg==
````

##### Step 5:

* Run `terraform destroy` to remove services related to KMS from AWS.

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
    
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/simple_encrypt/lab# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

aws_kms_key.oauth_config: Refreshing state... (ID: 4e78c7a7-8fdc-46ee-9db2-fcbf224afe0d)
data.aws_kms_ciphertext.oauth: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_kms_key.oauth_config


Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_kms_key.oauth_config: Destroying... (ID: 4e78c7a7-8fdc-46ee-9db2-fcbf224afe0d)
aws_kms_key.oauth_config: Still destroying... (ID: 4e78c7a7-8fdc-46ee-9db2-fcbf224afe0d, 10s elapsed)
aws_kms_key.oauth_config: Still destroying... (ID: 4e78c7a7-8fdc-46ee-9db2-fcbf224afe0d, 20s elapsed)
aws_kms_key.oauth_config: Destruction complete after 28s

Destroy complete! Resources: 1 destroyed.

```
