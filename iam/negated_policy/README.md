## AWS IAM - Negated Policy

>You manage access in AWS by creating negated policies and attaching them to IAM identities or AWS resources. A policy is an object in AWS that, when associated with an entity or resource, defines their permissions. AWS evaluates these policies when a principal, such as a user, makes a request


##### Step 1:

* Open Terminal

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/iam/negated_policy`

    ```commandline
    cd /home/vagrant/Desktop/Labs/AWS-Security-Training/iam/negated_policy
    ```
##### Step 3:

* Run `terraform init`

##### Step 4:

* Run `terraform apply`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue

##### Step 5:

* Run `terraform destroy`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
