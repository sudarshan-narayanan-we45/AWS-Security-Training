## AWS Cloudwatch Alarms

> Amazon Cloudwatch Alarms allows you to watch CloudWatch metrics and receive notifications when the metrics fall outside of the threshold configured (high or low). You can attach multiple Alarms to each metric that can have multiple actions.


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/we45/AWS-Security-Training/cloudwatch_alerts/lab`

    ```commandline
    cd /home/we45/AWS-Security-Training/cloudwatch_alerts/lab
    ```
    
    
##### Step 3:

* Run `terraform init`

    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudwatch_alerts/lab# terraform init
    
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
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudwatch_alerts/lab# terraform apply
    provider.aws.region
      The region where AWS operations will take place. Examples
      are us-east-1, us-west-2, etc.
    
      Default: us-east-1
      Enter a value: 
    
    data.aws_ami.target_ami: Refreshing state...
    
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      + aws_cloudtrail.cloudtrail
          id:                                          <computed>
          arn:                                         <computed>
          cloud_watch_logs_group_arn:                  "${aws_cloudwatch_log_group.cloudtrail_log.arn}"
          cloud_watch_logs_role_arn:                   "${aws_iam_role.cloudtrail_role.arn}"
          enable_log_file_validation:                  "true"
          enable_logging:                              "true"
          event_selector.#:                            "1"
          event_selector.0.include_management_events:  "true"
          event_selector.0.read_write_type:            "All"
          home_region:                                 <computed>
          include_global_service_events:               "true"
          is_multi_region_trail:                       "false"
          name:                                        "${var.trail_name}-${random_string.random_name.result}"
          s3_bucket_name:                              "${aws_s3_bucket.cloud_trail_log_bucket.id}"
          s3_key_prefix:                               "we45-demo-cloud-trail"
    + tls_private_key.we45_test_key
          id:                                          <computed>
          algorithm:                                   "RSA"
          ecdsa_curve:                                 "P224"
          private_key_pem:                             <computed>
          public_key_fingerprint_md5:                  <computed>
          public_key_openssh:                          <computed>
          public_key_pem:                              <computed>
          rsa_bits:                                    "4096"
    
    
    Plan: 29 to add, 0 to change, 0 to destroy.
    
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
    aws_instance.web_app: Creating...
      ami:                                       "" => "ami-428aa838"
      arn:                                       "" => "<computed>"
      associate_public_ip_address:               "" => "<computed>"
      availability_zone:                         "" => "<computed>"
      cpu_core_count:                            "" => "<computed>"
      cpu_threads_per_core:                      "" => "<computed>"
      ebs_block_device.#:                        "" => "<computed>"
      ephemeral_block_device.#:                  "" => "<computed>"
      get_password_data:                         "" => "false"
      instance_state:                            "" => "<computed>"
      instance_type:                             "" => "t2.micro"
      ipv6_address_count:                        "" => "<computed>"
      ipv6_addresses.#:                          "" => "<computed>"
      key_name:                                  "" => "we45_cloudwatch"
      network_interface.#:                       "" => "<computed>"
      network_interface_id:                      "" => "<computed>"
      password_data:                             "" => "<computed>"
      placement_group:                           "" => "<computed>"
      primary_network_interface_id:              "" => "<computed>"
      private_dns:                               "" => "<computed>"
      private_ip:                                "" => "<computed>"
      public_dns:                                "" => "<computed>"
      public_ip:                                 "" => "<computed>"
      root_block_device.#:                       "" => "1"
      root_block_device.0.delete_on_termination: "" => "true"
      root_block_device.0.volume_id:             "" => "<computed>"
      root_block_device.0.volume_size:           "" => "8"
      root_block_device.0.volume_type:           "" => "gp2"
      security_groups.#:                         "" => "<computed>"
      source_dest_check:                         "" => "true"
      subnet_id:                                 "" => "subnet-02b1f800f2c23665b"
      tags.%:                                    "" => "1"
      tags.Name:                                 "" => "WebApp-vlhv0cf5na"
      tenancy:                                   "" => "<computed>"
      user_data:                                 "" => "d1417b041f83fb580ea94f874afa08ec77331ba0"
      volume_tags.%:                             "" => "<computed>"
      vpc_security_group_ids.#:                  "" => "2"
      vpc_security_group_ids.2171827349:         "" => "sg-0c5f910a347c9d206"
      vpc_security_group_ids.3554873270:         "" => "sg-08ee26d57d5c51552"
    aws_route_table_association.route_table: Creation complete after 1s (ID: rtbassoc-0b3906b1eff52d1ad)
    aws_instance.web_app: Still creating... (10s elapsed)
    aws_instance.web_app: Still creating... (20s elapsed)
    aws_instance.web_app: Still creating... (30s elapsed)
    aws_instance.web_app: Still creating... (40s elapsed)
    aws_instance.web_app: Creation complete after 45s (ID: i-08d62d4767b5fbe02)
    
    Apply complete! Resources: 29 added, 0 changed, 0 destroyed.
    
    Outputs:
    
    connect_string = ssh -i we45_cloudwatch.pem ec2-user@<yourec2 instance public DNS>
    
    ```

##### Step 5 :
 
 * **cd** into  `/home/we45//AWS-Security-Training/cloudwatch_alerts/lab`
 
 * Give necessary permission to `400 we45_cloudwatch.pem` file
 
 * Run `chmod 400 we45_cloudwatch.pem`

    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudwatch_alerts/lab# chmod 400 we45_cloudwatch.pem
    ```
    
    
##### Step 6 :

 * Open terminal

 * **cd** into  `/home/we45//AWS-Security-Training/cloudwatch_alerts/lab`

 * Run `ssh -i we45_cloudwatch.pem ec2-user@<yourec2 instance public DNS>`
    
    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudwatch_alerts/lab# ssh -i we45_cloudwatch.pem ec2-user@<yourec2 instance public DNS>
    The authenticity of host '<yourec2 instance public DNS>' can't be established.
    ECDSA key fingerprint is SHA256:TRbEwAPPp93RRhCgvcNg554dMM.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '<yourec2 instance public DNS>' (ECDSA) to the list of known hosts.
    
           __|  __|_  )
           _|  (     /   Amazon Linux 2 AMI
          ___|\___|___|
    
    https://aws.amazon.com/amazon-linux-2/
    [ec2-user@ip-172-24-0-116 ~]$
    ```


##### Step 7 :

  * Open AWS console on the browser and check the created `Cloudwatch Alarms `.


##### Step 8 :
  * Go to Terminal and type `exit` to exit from the ec2 server.


##### Step 9 :
 
  * Run `terraform destroy` to remove services related to cloudwatch from AWS.
 
    1. It will ask you to enter **Region**
    2. It will ask permission to do the actions type `yes` and press enter to continue
    
    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudwatch_alerts/lab# terraform destroy
    provider.aws.region
      The region where AWS operations will take place. Examples
      are us-east-1, us-west-2, etc.
    
      Default: us-east-1
      Enter a value: 
    
    random_string.random_name: Refreshing state... (ID: none)
    tls_private_key.we45_test_key: Refreshing state... (ID: 9a64a4b85baa795aa02c63e654e4119e6de78327)
    local_file.aws_key: Refreshing state... (ID: 1749c323752ce01d0b6c924db97bd558414b52cf)
    aws_sns_topic.security_alerts: Refreshing state... (ID: arn:aws:sns:us-east-1:358174707935:security-alerts-topic-vlhv0cf5na)
    aws_key_pair.generated_key: Refreshing state... (ID: we45_cloudwatch)
    aws_sqs_queue.security_alerts: Refreshing state... (ID: https://sqs.us-east-1.amazonaws.com/358174707935/security-alerts-vlhv0cf5na)
    aws_s3_bucket.cloud_trail_log_bucket: Refreshing state... (ID: we45-log-cloudtrails20181204092238356700000001)
    data.aws_ami.target_ami: Refreshing state...
    - aws_sqs_queue_policy.sns_to_sqs
    
      - aws_subnet.example
    
      - aws_vpc.cloudwatch_vpc
    
      - local_file.aws_key
    
      - random_string.random_name
    
      - tls_private_key.we45_test_key
    
    
    Plan: 0 to add, 0 to change, 29 to destroy.
    
    Do you really want to destroy all resources?
      Terraform will destroy all your managed infrastructure, as shown above.
      There is no undo. Only 'yes' will be accepted to confirm.
    
      Enter a value: yes
    
    local_file.aws_key: Destroying... (ID: 1749c323752ce01d0b6c924db97bd558414b52cf)
    local_file.aws_key: Destruction complete after 0s
    aws_cloudwatch_metric_alarm.security_group_change: Destroying... (ID: security-group-changes-vlhv0cf5na)
    aws_default_security_group.cloudwatch_default: Destroying... (ID: sg-03929896142eedcfd)
    aws_route_table_association.route_table: Destroying... (ID: rtbassoc-0b3906b1eff52d1ad)
    aws_iam_role_policy.cloudtrail_policy: Destroying... (ID: we45_cloudtrail_role_vlhv0cf5na:we45_cloudtrail_policy_vlhv0cf5na)
    aws_cloudwatch_log_metric_filter.security_group_change: Destroying... (ID: security-group-changes-vlhv0cf5na)
    aws_s3_bucket_policy.cloud_trail_log_bucket_policy: Destroying... (ID: we45-log-cloudtrails20181204092238356700000001)
    aws_sqs_queue_policy.sns_to_sqs: Destroying... (ID: https://sqs.us-east-1.amazonaws.com/358174707935/security-alerts-vlhv0cf5na)
    aws_cloudwatch_log_metric_filter.iam_change: Destroying... (ID: iam-changes-vlhv0cf5na)
    aws_cloudwatch_log_metric_filter.root_login: Destroying... (ID: root-access-vlhv0cf5na)
    aws_cloudwatch_metric_alarm.root_login: Destroying... (ID: root-access-vlhv0cf5na)
    aws_default_security_group.cloudwatch_default: Destruction complete after 0s
    aws_cloudwatch_metric_alarm.iam_change: Destroying... (ID: iam-changes-vlhv0cf5na)
    aws_s3_bucket_policy.cloud_trail_log_bucket_policy: Destruction complete after 1s
    aws_sqs_queue_policy.sns_to_sqs: Destruction complete after 1s
    aws_cloudtrail.cloudtrail: Destroying... (ID: we45-demo-cloud-trail-vlhv0cf5na)
    aws_iam_role_policy.cloudtrail_policy: Destruction complete after 1s
    aws_sns_topic_subscription.security_alerts_to_sqs: Destroying... (ID: arn:aws:sns:us-east-1:358174707935:secu...a:b6fc02ce-360c-417e-97e4-2a6c2ebc2ed7)
    aws_instance.web_app: Destroying... (ID: i-08d62d4767b5fbe02)
    aws_route_table_association.route_table: Destruction complete after 1s
    aws_route_table.route: Destroying... (ID: rtb-05a6b4dfebed915b3)
    aws_cloudwatch_log_metric_filter.root_login: Destruction complete after 1s
    aws_cloudwatch_log_metric_filter.iam_change: Destruction complete after 1s
    aws_cloudwatch_log_metric_filter.security_group_change: Destruction complete after 1s
    aws_cloudwatch_metric_alarm.root_login: Destruction complete after 2s
    aws_cloudwatch_metric_alarm.iam_change: Destruction complete after 2s
    aws_cloudwatch_metric_alarm.security_group_change: Destruction complete after 2s
    aws_cloudtrail.cloudtrail: Destruction complete after 1s
    aws_s3_bucket.cloud_trail_log_bucket: Destroying... (ID: we45-log-cloudtrails20181204092238356700000001)
    aws_cloudwatch_log_group.cloudtrail_log: Destroying... (ID: we45-cloudtrail_log-vlhv0cf5na)
    aws_iam_role.cloudtrail_role: Destroying... (ID: we45_cloudtrail_role_vlhv0cf5na)
    tls_private_key.we45_test_key: Destruction complete after 0s
    aws_subnet.example: Destruction complete after 2s
    aws_security_group.allow_ssh_access: Destruction complete after 2s
    aws_security_group.http_out_access: Destruction complete after 2s
    random_string.random_name: Destroying... (ID: none)
    aws_vpc.cloudwatch_vpc: Destroying... (ID: vpc-08f580f52f1496981)
    random_string.random_name: Destruction complete after 0s
    aws_vpc.cloudwatch_vpc: Destruction complete after 1s
    
    Destroy complete! Resources: 29 destroyed.
    ```
