## Lynis

>Lynis performs Auditing, System hardening and
compliance tests on an EC2 instance. It performs an 
extensive health scan of the systems to support system 
hardening and compliance testing. 


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/lynis/lab`

```commandline
cd /home/vagrant/Desktop/Labs/AWS-Security-Training/lynis/lab
```

##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/lynis/lab# terraform init

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
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/lynis/lab# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_instance.web
      id:                                    <computed>
      ami:                                   "ami-2757f631"
      arn:                                   <computed>
      associate_public_ip_address:           <computed>
      availability_zone:                     <computed>
      cpu_core_count:                        <computed>
      cpu_threads_per_core:                  <computed>
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      get_password_data:                     "false"
      instance_state:                        <computed>
      instance_type:                         "t2.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              "we45_aws_lynis"
  public_key_openssh:                    <computed>
      public_key_pem:                        <computed>
      rsa_bits:                              "4096"


Plan: 6 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.random_name: Creating...
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
random_string.random_name: Creation complete after 0s (ID: none)
tls_private_key.we45_test_key: Creating...
  algorithm:                  "" => "RSA"
  ecdsa_curve:                "" => "P224"
  private_key_pem:            "" => "<computed>"
aws_instance.web (remote-exec): Processing triggers for install-info (6.1.0.dfsg.1-5) ...
aws_instance.web (remote-exec): Setting up lynis (2.1.1-1) ...
Progress: [ 72%] [##############Setting up menu (2.1.47ubuntu1.16.04.1) ...
Progress: [ 90%] [##############Processing triggers for menu (2.1.47ubuntu1.16.04.1) ...

aws_instance.web: Still creating... (1m0s elapsed)
aws_instance.web: Provisioning with 'local-exec'...
aws_instance.web (local-exec): Executing: ["/bin/sh" "-c" "chmod 400 we45_aws_lynis.pem && scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i we45_aws_lynis.pem ubuntu@54.172.132.239:/tmp/lynis-report.txt $(pwd)"]
aws_instance.web (local-exec): Warning: Permanently added '54.172.132.239' (ECDSA) to the list of known hosts.
aws_instance.web: Still creating... (1m10s elapsed)
aws_instance.web: Creation complete after 1m11s (ID: i-0d1ac23c479a06792)

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

```


##### Step 5:

* Run `terraform destroy`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
    
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/lynis/lab# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

tls_private_key.we45_test_key: Refreshing state... (ID: 68b09b93906764ab8c9d47d8ab40ddab2281e1df)
local_file.aws_key: Refreshing state... (ID: 4f6a88d3ff8fed6bac4a6a67c30353a57f5929d4)
random_string.random_name: Refreshing state... (ID: none)
aws_security_group.allow_ssh: Refreshing state... (ID: sg-0377d6aceb304cfca)
aws_key_pair.generated_key: Refreshing state... (ID: we45_aws_lynis)
 - local_file.aws_key

  - random_string.random_name

  - tls_private_key.we45_test_key


Plan: 0 to add, 0 to change, 6 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.web: Destroying... (ID: i-0d1ac23c479a06792)
aws_instance.web: Still destroying... (ID: i-0d1ac23c479a06792, 10s elapsed)
aws_key_pair.generated_key: Destruction complete after 1s
tls_private_key.we45_test_key: Destroying... (ID: 68b09b93906764ab8c9d47d8ab40ddab2281e1df)
tls_private_key.we45_test_key: Destruction complete after 0s
aws_security_group.allow_ssh: Destruction complete after 2s
random_string.random_name: Destroying... (ID: none)
random_string.random_name: Destruction complete after 0s

Destroy complete! Resources: 6 destroyed.

```
