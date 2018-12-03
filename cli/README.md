## Configuring AWS-Command Line Interface (CLI)
>Using AWS CLI we can control multiple AWS Services from 
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

**Note:**  AWS CLI requires python>=2.6.5 and python pip for installation. 

* Run `pip install awscli`



##### Step 4:

* Run `aws version`

```commandline
aws --version
aws-cli/1.16.18 Python/2.7.10 Darwin/18.0.0 botocore/1.12.8
``` 

##### Step 5 :

We should provide our **AWS Access Key**, **AWS Secret KEY** and **Region** to configure AWS CLI

* Run `aws configure`

```commandline
aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: 
```

This command is interactive and prompts you to enter additional information. Enter your Access Key ID, Secret Access Key, Region Name and skip the Output Format using the ENTER Key allowing it to take the default value.



**Note:**  AWS CLI is now ready to use.
