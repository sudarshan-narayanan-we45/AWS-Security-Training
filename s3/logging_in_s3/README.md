## AWS S3 Static Website Hosting with Logging 

>Using Amazon S3  we can deploy a static application as well as 
we can log the server information in the S3 bucket.


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  ` /home/vagrant/Desktop/Labs/AWS-Security-Training/s3/logging_in_s3/lab`

```commandline
cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/s3/logging_in_s3/lab
```
##### Step 3:

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

##### Step 4 :

* Open the link in the browser, which was shown in the terminal output

##### Step 5 :
 
 * Run `terraform destroy` to remove the S3 from the AWS.
 * **Note:** It will ask your permission to destroy the created EC2 from the AWS `Do you really want to destroy all resources?` then type 'yes' then press `enter
 to continue the process. 
  
 ```commandline
  
  Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
  aws_flow_log.ucsf_aws_vpc_flow_log: Destroying... (ID: fl-0213b696e3b6c5c4e)
  Destroy complete! Resources: 5 destroyed.
```
