## Amazon S3

>


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/s3/insecure`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/s3/insecure
    ```

##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/insecure# terraform init

Initializing provider plugins...

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
    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
    
 ```commandline
 root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/insecure# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_s3_bucket.public_bucket
      id:                          <computed>
      acceleration_status:         <computed>
      acl:                         "public-read"
      arn:                         <computed>
      bucket:                      "${random_string.bucket_name.result}-bucket.we45.com"
      bucket_domain_name:          <computed>
      bucket_regional_domain_name: <computed>
      force_destroy:               "true"
      hosted_zone_id:              <computed>
      region:                      <computed>
      request_payer:               <computed>
      versioning.#:                <computed>
      website_domain:              <computed>
      website_endpoint:            <computed>

  + random_string.bucket_name
      id:                          <computed>
      length:                      "10"
      lower:                       "true"
      min_lower:                   "0"
      min_numeric:                 "0"
      min_special:                 "0"
      min_upper:                   "0"
      number:                      "true"
      result:                      <computed>
      special:                     "false"
      upper:                       "false"


Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.bucket_name: Creating...
  length:      "" => "10"
  lower:       "" => "true"
  min_lower:   "" => "0"
  min_numeric: "" => "0"
  min_special: "" => "0"
  min_upper:   "" => "0"
  number:      "" => "true"
  versioning.#:                "" => "<computed>"
  website_domain:              "" => "<computed>"
  website_endpoint:            "" => "<computed>"
aws_s3_bucket.public_bucket: Still creating... (10s elapsed)
aws_s3_bucket.public_bucket: Creation complete after 12s (ID: nlz846402x-bucket.we45.com)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.


 ```

##### Step 5:

* Run `terraform destroy`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
   
```commandline
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

random_string.bucket_name: Refreshing state... (ID: none)
aws_s3_bucket.public_bucket: Refreshing state... (ID: nlz846402x-bucket.we45.com)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_s3_bucket.public_bucket

  - random_string.bucket_name


Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket.public_bucket: Destroying... (ID: nlz846402x-bucket.we45.com)
aws_s3_bucket.public_bucket: Destruction complete after 1s
random_string.bucket_name: Destroying... (ID: none)
random_string.bucket_name: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.

```
