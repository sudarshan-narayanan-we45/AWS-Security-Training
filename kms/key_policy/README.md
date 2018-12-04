## Amazon KMS

>


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/kms/key_policy/lab`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/kms/key_policy/lab
    ```

##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/key_policy/lab# terraform init

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

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/key_policy/lab# terraform apply
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

 <= data.aws_iam_policy_document.appkeypolicy
      id:                             <computed>
      json:                           <computed>
      statement.#:                    "1"
      statement.0.actions.#:          "1"
      statement.0.actions.1011197950: "kms:*"
      statement.0.effect:             "Allow"
      statement.0.resources.#:        <computed>
      statement.0.sid:                "1"
 policy:                         <computed>
      tags.%:                         "1"
      tags.Name:                      "Test Key with Policy"


Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
aws_iam_role.app_key_role: Creating...
  arn:                   "" => "<computed>"
  assume_role_policy:    "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}\n"
  create_date:           "" => "<computed>"
  force_detach_policies: "" => "false"
aws_iam_policy.ApplicationKeyPolicy: Creation complete after 3s (ID: arn:aws:iam::358174707935:policy/terraform-20181204133052954500000001)
aws_iam_policy_attachment.AppKeyRolePolicy: Creating...
  name:             "" => "appkey role policy attachment"
  policy_arn:       "" => "arn:aws:iam::358174707935:policy/terraform-20181204133052954500000001"
  roles.#:          "" => "1"
  roles.2225695218: "" => "app-key-role"
aws_iam_policy_attachment.AppKeyRolePolicy: Creation complete after 3s (ID: appkey role policy attachment)

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

```


##### Step 5:


* Run `terraform destroy` to remove services related to KMS from AWS.

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/key_policy/lab# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

aws_kms_key.test_key: Refreshing state... (ID: 941049ff-b703-44eb-9031-d6cc8298923d)
aws_iam_role.app_key_role: Refreshing state... (ID: app-key-role)
- aws_iam_role.app_key_role

  - aws_kms_key.test_key


Plan: 0 to add, 0 to change, 4 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
aws_iam_policy_attachment.AppKeyRolePolicy: Destroying... (ID: appkey role policy attachment)
aws_iam_policy_attachment.AppKeyRolePolicy: Destruction complete after 1s
aws_iam_policy.ApplicationKeyPolicy: Destroying... (ID: arn:aws:iam::358174707935:policy/terraform-20181204133052954500000001)
aws_iam_role.app_key_role: Destroying... (ID: app-key-role)
aws_iam_policy.ApplicationKeyPolicy: Destruction complete after 2s
aws_kms_key.test_key: Destroying... (ID: 941049ff-b703-44eb-9031-d6cc8298923d)
aws_kms_key.test_key: Still destroying... (ID: 941049ff-b703-44eb-9031-d6cc8298923d, 10s elapsed)
aws_kms_key.test_key: Still destroying... (ID: 941049ff-b703-44eb-9031-d6cc8298923d, 20s elapsed)
aws_kms_key.test_key: Destruction complete after 28s

Destroy complete! Resources: 4 destroyed.

```
