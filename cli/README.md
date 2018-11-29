## Configuring AWS-Command Line Interface (CLI)
>Using AWS CLI we can control AWS multiple Services from 
the command line.


##### Step 1:

* Open Terminal

	![](img/terminal.png)

##### Step 2:

*  **cd** into  ` /home/vagrant/Desktop/Labs/AWS-Security-Training/cli`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/cli
    ```

##### Step 3:

**Note:** To Install AWS CLI Requires Python 2.6.5 or higher. And python pip is required. 

* Run `pip install awscli`



##### Step 4:

* Run `aws version`

```commandline
aws --version
aws-cli/1.16.18 Python/2.7.10 Darwin/18.0.0 botocore/1.12.8
``` 

##### Step 5 :

To Interact with AWS we should configure AWS CLI . We should give our **AWS Access Key**, **AWS Secret KEY** and **Region**

* Run `aws configure`

```commandline
aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: ENTER
```

This command is interactive, so the AWS CLI outputs lines of texts, prompting you to enter additional information. Enter each of your access keys in turn and press Enter. Then, enter a region name in the format shown, press Enter, and press Enter a final time to skip the output format setting.



**Note:** Now AWS CLI is ready to use.
