## AWS IAM 

>You manage access in AWS by creating policies and attaching them to IAM identities or AWS resources. A policy is an object in AWS that, when associated with an entity or resource, defines their permissions. AWS evaluates these policies when a principal, such as a user, makes a request. 


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/iam/user_group/lab`

    ```commandline
    cd /home/vagrant/Desktop/Labs/AWS-Security-Training/iam/user_group/lab
    ```
##### Step 3:

* Run `terraform init`

    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/iam/user_group# terraform init
    
    Initializing provider plugins...
    - Checking for available provider plugins on https://releases.hashicorp.com...
    - Downloading plugin for provider "random" (2.0.0)...
    - Downloading plugin for provider "aws" (1.50.0)...
    
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

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/iam/user_group# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_iam_group.group
      id:                          <computed>
      arn:                         <computed>
      name:                        "${random_string.bucket_name.result}-uploads-test-group"
      path:                        "/"
      unique_id:                   <computed>
Plan: 7 to add, 0 to change, 0 to destroy.

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
random_string.bucket_name: Creation complete after 0s (ID: none)
aws_iam_user.user_one: Creating...
  arn:           "" => "<computed>"
  force_destroy: "" => "false"
  name:          "" => "gnit70navw-uploads-test-user"
  path:          "" => "/"
  unique_id:     "" => "<computed>"
aws_s3_bucket.upload-bucket: Creating...
  acceleration_status:         "" => "<computed>"
  acl:                         "" => "private"
  arn:                         "" => "<computed>"
  bucket:                      "" => "gnit70navw-uploads"
  bucket_domain_name:          "" => "<computed>"
  bucket_regional_domain_name: "" => "<computed>"
aws_s3_bucket.upload-bucket: Creation complete after 12s (ID: gnit70navw-uploads)
aws_iam_policy.policy: Creating...
  arn:         "" => "<computed>"
  description: "" => "gnit70navw-uploads"
  name:        "" => "gnit70navw-uploads-policy"
  path:        "" => "/"
  policy:      "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": [\n        \"s3:PutItem\"\n      ],\n      \"Effect\": \"Allow\",\n      \"Resource\": \"arn:aws:s3:::gnit70navw-uploads\"\n    }\n  ]\n}\n"
aws_iam_policy.policy: Creation complete after 2s (ID: arn:aws:iam::358174707935:policy/gnit70navw-uploads-policy)
aws_iam_group_policy_attachment.test-attach: Creating...
  group:      "" => "gnit70navw-uploads-test-group"
  policy_arn: "" => "arn:aws:iam::358174707935:policy/gnit70navw-uploads-policy"
aws_iam_group_policy_attachment.test-attach: Creation complete after 3s (ID: gnit70navw-uploads-test-group-20181204120142302300000001)

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.


```

##### Step 5:

* Run `terraform destroy`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
    
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/iam/user_group# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

random_string.bucket_name: Refreshing state... (ID: none)
 - aws_iam_user.user_one

  - aws_s3_bucket.upload-bucket

  - random_string.bucket_name


Plan: 0 to add, 0 to change, 7 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
aws_iam_user.user_one: Destruction complete after 2s
aws_s3_bucket.upload-bucket: Destruction complete after 1s
random_string.bucket_name: Destroying... (ID: none)
random_string.bucket_name: Destruction complete after 0s

Destroy complete! Resources: 7 destroyed.

```
