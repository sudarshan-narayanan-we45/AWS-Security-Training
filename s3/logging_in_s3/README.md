## AWS S3 Static Website Hosting with Logging 

>Using Amazon S3, we can deploy a static application and log the server information in the S3 bucket.


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  ` /home/vagrant/Desktop/Labs/AWS-Security-Training/s3/logging_in_s3/lab`

```commandline
cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/s3/logging_in_s3/lab
```
##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/logging_in_s3/lab# terraform init

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

```commandline
terraform apply


Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
  
  
aws_vpc.ucsf-vpc: Creating...
  arn:                              "" => "<computed>"

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

##### Step 5 :

* Open the link shown as an output in the terminal on the browser.

##### Step 6 :
 
 * Run `terraform destroy` to remove the S3 from the AWS.
 * **Note:** It will ask your permission to destroy the created EC2 from AWS (`Do you really want to destroy all resources?`). Type 'yes' and press `enter`
 to continue the process. 
  
 ```commandline
  
  Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
  aws_flow_log.ucsf_aws_vpc_flow_log: Destroying... (ID: fl-0213b696e3b6c5c4e)
  Destroy complete! Resources: 5 destroyed.
```
