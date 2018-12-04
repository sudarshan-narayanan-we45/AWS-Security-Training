## CloudTrail

>AWS CloudTrail is an AWS service that helps you enable governance, compliance, and operational and risk auditing of your AWS account. Actions taken by a user, role, or an AWS service are recorded as events in CloudTrail. Events include actions taken in the AWS Management Console, AWS Command Line Interface, and AWS SDKs and APIs. 


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/cloudtrail/lab`

    ```commandline
    cd /home/vagrant/Desktop/Labs/AWS-Security-Training/cloudtrail/lab
    ```
    
##### Step 3:

* Run `terraform init` 


    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudtrail/lab# terraform init
    
    Initializing provider plugins...
    
    The following providers do not have any version constraints in configuration,
    so the latest version was installed.
    
    To prevent automatic upgrades to new major versions that may contain breaking
    changes, it is recommended to add version = "..." constraints to the
    corresponding provider blocks in configuration, with the constraint strings
    suggested below.
    
    * provider.aws: version = "~> 1.49"
    
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
2. It will ask permission to do the actions type `yes` and press enter to continue

```commandline
``` 
