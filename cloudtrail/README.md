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
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudtrail/lab# terraform apply
    provider.aws.region
      The region where AWS operations will take place. Examples
      are us-east-1, us-west-2, etc.
    
      Default: us-east-1
      Enter a value: 
    
    
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      + aws_cloudtrail.we45_cloudtrial
          id:                                         <computed>
          arn:                                        <computed>
          enable_log_file_validation:                 "false"
          enable_logging:                             "true"
          event_selector.#:                           "1"
          event_selector.0.data_resource.#:           "1"
          event_selector.0.data_resource.0.type:      "AWS::S3::Object"
          event_selector.0.data_resource.0.values.#:  "1"
          event_selector.0.data_resource.0.values.0:  "arn:aws:s3:::"
          event_selector.0.include_management_events: "true"
          event_selector.0.read_write_type:           "All"
          home_region:                                <computed>
          include_global_service_events:              "false"
          is_multi_region_trail:                      "false"
          name:                                       "we45-trail-cloudtrails"
          s3_bucket_name:                             "${aws_s3_bucket.cloud_trail_log_bucket.id}"
    
      + aws_s3_bucket.cloud_trail_log_bucket
          id:                                         <computed>
          acceleration_status:                        <computed>
          acl:                                        "private"
          arn:                                        <computed>
          bucket:                                     <computed>
          bucket_domain_name:                         <computed>
          bucket_prefix:                              "we45-log-cloudtrails"
          bucket_regional_domain_name:                <computed>
          force_destroy:                              "true"
          hosted_zone_id:                             <computed>
          region:                                     <computed>
          request_payer:                              <computed>
          versioning.#:                               <computed>
          website_domain:                             <computed>
          website_endpoint:                           <computed>
    
      + aws_s3_bucket_policy.cloud_trail_log_bucket_policy
          id:                                         <computed>
          bucket:                                     "${aws_s3_bucket.cloud_trail_log_bucket.id}"
          policy:                                     "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"Allow bucket ACL check\",\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": [\n          \"cloudtrail.amazonaws.com\"\n          ]\n        },\n      \"Action\": \"s3:GetBucketAcl\",\n      \"Resource\": \"${aws_s3_bucket.cloud_trail_log_bucket.arn}\"\n    },\n    {\n      \"Sid\": \"Allow bucket write\",\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": [\n          \"cloudtrail.amazonaws.com\"\n        ]\n      },\n      \"Action\": \"s3:PutObject\",\n      \"Resource\": \"${aws_s3_bucket.cloud_trail_log_bucket.arn}/*\",\n      \"Condition\": {\"StringEquals\": {\"s3:x-amz-acl\": \"bucket-owner-full-control\"}}\n    }\n  ]\n}\n"
    
    
    Plan: 3 to add, 0 to change, 0 to destroy.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    aws_s3_bucket.cloud_trail_log_bucket: Creating...
      acceleration_status:         "" => "<computed>"
      acl:                         "" => "private"
      arn:                         "" => "<computed>"
      bucket:                      "" => "<computed>"
      bucket_domain_name:          "" => "<computed>"
      bucket_prefix:               "" => "we45-log-cloudtrails"
      bucket_regional_domain_name: "" => "<computed>"
      force_destroy:               "" => "true"
      hosted_zone_id:              "" => "<computed>"
      region:                      "" => "<computed>"
      request_payer:               "" => "<computed>"
      versioning.#:                "" => "<computed>"
      website_domain:              "" => "<computed>"
      website_endpoint:            "" => "<computed>"
    aws_s3_bucket.cloud_trail_log_bucket: Still creating... (10s elapsed)
    aws_s3_bucket.cloud_trail_log_bucket: Creation complete after 12s (ID: we45-log-cloudtrails20181204083814827700000001)
    aws_s3_bucket_policy.cloud_trail_log_bucket_policy: Creating...
      bucket: "" => "we45-log-cloudtrails20181204083814827700000001"
      policy: "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"Allow bucket ACL check\",\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": [\n          \"cloudtrail.amazonaws.com\"\n          ]\n        },\n      \"Action\": \"s3:GetBucketAcl\",\n      \"Resource\": \"arn:aws:s3:::we45-log-cloudtrails20181204083814827700000001\"\n    },\n    {\n      \"Sid\": \"Allow bucket write\",\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": [\n          \"cloudtrail.amazonaws.com\"\n        ]\n      },\n      \"Action\": \"s3:PutObject\",\n      \"Resource\": \"arn:aws:s3:::we45-log-cloudtrails20181204083814827700000001/*\",\n      \"Condition\": {\"StringEquals\": {\"s3:x-amz-acl\": \"bucket-owner-full-control\"}}\n    }\n  ]\n}\n"
    aws_cloudtrail.we45_cloudtrial: Creating...
      arn:                                        "" => "<computed>"
      enable_log_file_validation:                 "" => "false"
      enable_logging:                             "" => "true"
      event_selector.#:                           "" => "1"
      event_selector.0.data_resource.#:           "" => "1"
      event_selector.0.data_resource.0.type:      "" => "AWS::S3::Object"
      event_selector.0.data_resource.0.values.#:  "" => "1"
      event_selector.0.data_resource.0.values.0:  "" => "arn:aws:s3:::"
      event_selector.0.include_management_events: "" => "true"
      event_selector.0.read_write_type:           "" => "All"
      home_region:                                "" => "<computed>"
      include_global_service_events:              "" => "false"
      is_multi_region_trail:                      "" => "false"
      name:                                       "" => "we45-trail-cloudtrails"
      s3_bucket_name:                             "" => "we45-log-cloudtrails20181204083814827700000001"
    aws_s3_bucket_policy.cloud_trail_log_bucket_policy: Creation complete after 1s (ID: we45-log-cloudtrails20181204083814827700000001)
    aws_cloudtrail.we45_cloudtrial: Creation complete after 8s (ID: we45-trail-cloudtrails)
    
    Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
    
    ``` 


##### Step 4:

* Open AWS console on the browser and check the created `cloudtrail` and check the logs in the `s3` bucket

##### Step 5:

* Run `terraform destroy` to remove all the cloudtrail related resources

    1. It will ask you to enter **Region**
    2. It will ask permission to do the actions type `yes` and press enter to continue 
    
    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cloudtrail/lab# terraform destroy
    provider.aws.region
      The region where AWS operations will take place. Examples
      are us-east-1, us-west-2, etc.
    
      Default: us-east-1
      Enter a value: 
    
    aws_s3_bucket.cloud_trail_log_bucket: Refreshing state... (ID: we45-log-cloudtrails20181204083814827700000001)
    aws_s3_bucket_policy.cloud_trail_log_bucket_policy: Refreshing state... (ID: we45-log-cloudtrails20181204083814827700000001)
    aws_cloudtrail.we45_cloudtrial: Refreshing state... (ID: we45-trail-cloudtrails)
    
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      - destroy
    
    Terraform will perform the following actions:
    
      - aws_cloudtrail.we45_cloudtrial
    
      - aws_s3_bucket.cloud_trail_log_bucket
    
      - aws_s3_bucket_policy.cloud_trail_log_bucket_policy
    
    
    Plan: 0 to add, 0 to change, 3 to destroy.
    
    Do you really want to destroy all resources?
      Terraform will destroy all your managed infrastructure, as shown above.
      There is no undo. Only 'yes' will be accepted to confirm.
    
      Enter a value: yes
    
    aws_cloudtrail.we45_cloudtrial: Destroying... (ID: we45-trail-cloudtrails)
    aws_s3_bucket_policy.cloud_trail_log_bucket_policy: Destroying... (ID: we45-log-cloudtrails20181204083814827700000001)
    aws_s3_bucket_policy.cloud_trail_log_bucket_policy: Destruction complete after 0s
    aws_cloudtrail.we45_cloudtrial: Destruction complete after 1s
    aws_s3_bucket.cloud_trail_log_bucket: Destroying... (ID: we45-log-cloudtrails20181204083814827700000001)
    aws_s3_bucket.cloud_trail_log_bucket: Destruction complete after 4s
    
    Destroy complete! Resources: 3 destroyed.
    
    ```
