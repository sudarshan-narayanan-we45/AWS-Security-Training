## AWS IAM 

>You manage access in AWS by creating policies and attaching them to IAM identities or AWS resources. A policy is an object in AWS that, when associated with an entity or resource, defines their permissions. AWS evaluates these policies when a principal, such as a user, makes a request. 


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/iam/role_policy/lab`

    ```commandline
    cd /home/vagrant/Desktop/Labs/AWS-Security-Training/iam/role_policy/lab
    ```
##### Step 3:

* Run `terraform init`

    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/iam/role_policy# terraform init
    
    Initializing provider plugins...
    - Checking for available provider plugins on https://releases.hashicorp.com...
    - Downloading plugin for provider "aws" (1.50.0)...
    - Downloading plugin for provider "random" (2.0.0)...
    - Downloading plugin for provider "tls" (1.2.0)...
    - Downloading plugin for provider "local" (1.1.0)...
    
    The following providers do not have any version constraints in configuration,
    so the latest version was installed.
    
    To prevent automatic upgrades to new major versions that may contain breaking
    changes, it is recommended to add version = "..." constraints to the
    corresponding provider blocks in configuration, with the constraint strings
    suggested below.
    
    * provider.aws: version = "~> 1.50"
    * provider.local: version = "~> 1.1"
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
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/iam/role_policy# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

data.aws_ami.amz_linux: Refreshing state...
+ tls_private_key.we45_test_key
      id:                                    <computed>
      algorithm:                             "RSA"
      ecdsa_curve:                           "P224"
      private_key_pem:                       <computed>
      public_key_fingerprint_md5:            <computed>
      public_key_openssh:                    <computed>
      public_key_pem:                        <computed>
      rsa_bits:                              "4096"


Plan: 11 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.bucket_name: Creating...
  length:      "" => "10"
  lower:       "" => "true"
  min_lower:   "" => "0"

aws_instance.test-host: Still creating... (1m20s elapsed)
aws_instance.test-host (remote-exec): 2018-12-04 11:52:28         11 hello.txt
aws_instance.test-host: Creation complete after 1m24s (ID: i-05a509fe18311b96a)

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

aws_iam_role_profile_name = Role: arn:aws:iam::358174707935:role/terraform-20181204115129072200000001, Profile: arn:aws:iam::358174707935:instance-profile/test_profile


```


##### Step 5 :

* Run `terraform destroy`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/iam/role_policy# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

random_string.bucket_name: Refreshing state... (ID: none)
tls_private_key.we45_test_key: Refreshing state... (ID: da2f393af8f4114ba58edcbbc14f9458b1c9d043)
local_file.aws_key: Refreshing state... (ID: a60ba69a50977c297a549d966882e78ca69f2642)
 - aws_iam_role_policy.attach-policy

  - aws_instance.test-host

  - aws_key_pair.generated_key

  - aws_s3_bucket.ec2-bucket

  - aws_s3_bucket_object.hello_file

  - aws_security_group.host_security_group

  - local_file.aws_key

  - random_string.bucket_name

  - tls_private_key.we45_test_key


Plan: 0 to add, 0 to change, 11 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

local_file.aws_key: Destroying... (ID: a60ba69a50977c297a549d966882e78ca69f2642)
local_file.aws_key: Destruction complete after 0s
aws_security_group.host_security_group: Destroying... (ID: sg-083ae8dd76e14c40a)
aws_s3_bucket.ec2-bucket: Destroying... (ID: rkf0bq74ca-uploads)
aws_key_pair.generated_key: Destroying... (ID: we45_iam_role_policy)
aws_key_pair.generated_key: Destruction complete after 1s
tls_private_key.we45_test_key: Destroying... (ID: da2f393af8f4114ba58edcbbc14f9458b1c9d043)
tls_private_key.we45_test_key: Destruction complete after 0s
aws_s3_bucket.ec2-bucket: Destruction complete after 1s
random_string.bucket_name: Destroying... (ID: none)
random_string.bucket_name: Destruction complete after 0s
aws_iam_instance_profile.test_profile: Destruction complete after 2s
aws_iam_role.tes_role: Destroying... (ID: terraform-20181204115129072200000001)
aws_security_group.host_security_group: Destruction complete after 2s
aws_iam_role.tes_role: Destruction complete after 2s

Destroy complete! Resources: 11 destroyed.

```
