## AWS Virtual Private Cloud (VPC)

>Using AWS VPC we can create a virtual network for our AWS resources.This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS.


##### Step 1:

* Open Terminal

##### Step 2:

*  **cd** into  `/home/we45/AWS-Security-Training/vpc`

    ```commandline
    cd /home/we45/AWS-Security-Training/vpc
    ```

##### Step 3:

* Run `terraform apply`

**Note:** Once you press enter it will ask you a permission to do the action like `Do you want to perform these actions?`
then type `yes` and press `enter` it will continues the rest of the actions.
```commandline
terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_vpc.ucsf-vpc
      id:                               <computed>
      arn:                              <computed>
      assign_generated_ipv6_cidr_block: "false"
      cidr_block:                       "10.0.0.0/16"


Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
  
  
aws_vpc.ucsf-vpc: Creating...
  arn:                              "" => "<computed>"

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

##### Step 4 :

* Open AWS console in the browser and check the created `VPC`.

 ##### Step 5 :
 
 * Run `terraform destroy` to remove the VCP from the AWS.
 
 **Note:** It will ask your permission to destroy the created VPC from the AWS `Do you really want to destroy all resources?` then type 'yes' then press `enter
 to continue the process. 
 ```commandline
 
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
  aws_vpc.ucsf-vpc: Destruction complete after 1s

    Destroy complete! Resources: 1 destroyed.

```


##### Overall Network looks like

![](img/internet-gateway-diagram.png)
