## AWS Cloudwatch Alarms

>Using Amazon Cloudwatch Alarms feature allows you to watch CloudWatch metrics and to receive notifications when the metrics fall outside of the levels (high or low thresholds) that you configure. You can attach multiple Alarms to each metric and each one can have multiple actions.


##### Step 1:

* Open Terminal

##### Step 2:

*  **cd** into  `/home/we45/AWS-Security-Training/cloudwatch_alarm/lab`

    ```commandline
    cd /home/we45/AWS-Security-Training/cloudwatch_alarm/lab
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

+ tls_private_key.ucsf_test_key
      id:                                                                  <computed>
      algorithm:                                                           "RSA"
      ecdsa_curve:                                                         "P224"
      private_key_pem:                                                     <computed>
      public_key_fingerprint_md5:                                          <computed>
      public_key_openssh:                                                  <computed>
      public_key_pem:                                                      <computed>
      rsa_bits:                                                            "4096"


Plan: 28 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
  Apply complete! Resources: 23 added, 0 changed, 2 destroyed.

Outputs:

connect_string = ssh -i /Users/tilakt/.ssh/aws_tilak_test.pub.pem ec2-user@ec2-18-212-10-166.compute-1.amazonaws.com
private_key = -----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
```

##### Step 4 :
* Copy the Private_key and create a  `ucsf_cloudwatch.pem` and paste the private_key data 
* Give permission for the `ucsf_cloudwatch.pem` file
```commandline
chmod 400 ucsf_cloudwatch.pem
```

##### Step 5 :

* Open AWS console in the browser and check the created `Cloudwatch Alarms `.

##### Step 6 :

* Open terminal
```commandline
ssh -i ucsf_cloudwatch.pem ec2-user@<yourec2 instance public DNS>
ECDSA key fingerprint is SHA256:RI0dniMEy2SoWdwF2L3dNPBfkI2r85qa9fFZm6xrgo0.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-18-212-10-166.compute-1.amazonaws.com,18.212.10.166' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[ec2-user@ip-172-24-0-152 ~]$

```

##### Step 7 :
Open AWS console in the browser and check the created `Cloudwatch Alarms `. it will show a alarms


##### Step 8 :
Goto Terminal and type `exit` to exit from the ec2 server.



 ##### Step 9 :
 
 * Run `terraform destroy` to remove the the related to the cloudwatch from the AWS.
 
 **Note:** It will ask your permission to destroy the created cloudwatch realated from the AWS `Do you really want to destroy all resources?` then type 'yes' then press `enter
 to continue the process. 
 
 ```commandline
 
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
  aws_flow_log.ucsf_aws_vpc_flow_log: Destroying... (ID: fl-0213b696e3b6c5c4e)
  aws_iam_role_policy.ucsf_vpc_flow_log_iam_policy: Destroying... (ID: ucsf_flowlogsRole:ucsf_flowlogsRolePolicy)
  aws_iam_role_policy.ucsf_vpc_flow_log_iam_policy: Destruction complete after 1s
  aws_flow_log.ucsf_aws_vpc_flow_log: Destruction complete after 4s
  aws_iam_role.vpc_flow_iam_role: Destroying... (ID: ucsf_flowlogsRole)
  aws_cloudwatch_log_group.vpc_flow_cloud_watch_group: Destroying... (ID: ucsf-aws-vpc-flow-log)
  aws_vpc.ucsf-vpc: Destroying... (ID: vpc-0abd67f8f4ffe1199)
  aws_cloudwatch_log_group.vpc_flow_cloud_watch_group: Destruction complete after 2s
  aws_vpc.ucsf-vpc: Destruction complete after 2s
  aws_iam_role.vpc_flow_iam_role: Destruction complete after 2s

  Destroy complete! Resources: 5 destroyed.
```
