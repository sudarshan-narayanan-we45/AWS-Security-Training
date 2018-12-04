## Amazon S3

>


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/s3/encryption_s3`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/s3/encryption_s3
    ```

##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/encryption_s3# terraform init

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
 root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/encryption_s3# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_kms_key.s3_key
      id:                                                                                                        <computed>
      arn:                                                                                                       <computed>
      deletion_window_in_days:                                                                                   "10"
      description:                                                                                               "This key is used to encrypt bucket objects"
      enable_key_rotation:                                                                                       "false"
      is_enabled:                                                                                                "true"
      key_id:                                                                                                    <computed>
      key_usage:                                                                                                 <computed>
      policy:                                                                                                    <computed>
 result:                                                                                                    <computed>
      special:                                                                                                   "false"
      upper:                                                                                                     "false"


Plan: 3 to add, 0 to change, 0 to destroy.

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
  result:      "" => "<computed>"
  special:     "" => "false"
  upper:       "" => "false"
  server_side_encryption_configuration.0.rule.0.apply_server_side_encryption_by_default.0.sse_algorithm:     "" => "aws:kms"
  versioning.#:                                                                                              "" => "<computed>"
  website_domain:                                                                                            "" => "<computed>"
  website_endpoint:                                                                                          "" => "<computed>"
aws_s3_bucket.secret_bucket: Still creating... (10s elapsed)
aws_s3_bucket.secret_bucket: Creation complete after 13s (ID: sxf66n8102-we45-training)

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

 ```

##### Step 5:

* Run `terraform destroy`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
   
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/encryption_s3# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

random_string.bucket_name: Refreshing state... (ID: none)
aws_kms_key.s3_key: Refreshing state... (ID: ac93fb1b-eae6-4cda-a590-ef3e260cf1d7)
aws_s3_bucket.secret_bucket: Refreshing state... (ID: sxf66n8102-we45-training)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_kms_key.s3_key

  - aws_s3_bucket.secret_bucket

  - random_string.bucket_name


Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket.secret_bucket: Destroying... (ID: sxf66n8102-we45-training)
aws_s3_bucket.secret_bucket: Destruction complete after 1s
aws_kms_key.s3_key: Destroying... (ID: ac93fb1b-eae6-4cda-a590-ef3e260cf1d7)
random_string.bucket_name: Destroying... (ID: none)
random_string.bucket_name: Destruction complete after 0s
aws_kms_key.s3_key: Still destroying... (ID: ac93fb1b-eae6-4cda-a590-ef3e260cf1d7, 10s elapsed)
aws_kms_key.s3_key: Still destroying... (ID: ac93fb1b-eae6-4cda-a590-ef3e260cf1d7, 20s elapsed)
aws_kms_key.s3_key: Destruction complete after 28s

Destroy complete! Resources: 3 destroyed.

```
