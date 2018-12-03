## Configuring AWS-Command Line Interface (CLI)
>Using AWS CLI we can control AWS multiple Services from 
the command line.


##### Step 1:

* Open Terminal

	![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/cli`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/cli
    ```


##### Step 3 :

To Interact with AWS we should configure AWS CLI . We should give our **AWS Access Key**, **AWS Secret KEY** and **Region**

* Run `aws configure`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cli# aws configure
AWS Access Key ID [****************AFLQ]: 
AWS Secret Access Key [****************V4LV]: 
Default region name [us-east-1]: 
Default output format [json]: 
```

This command is interactive, so the AWS CLI outputs lines of texts, prompting you to enter additional information. Enter each of your access keys in turn and press Enter. Then, enter a region name in the format shown, press Enter, and press Enter a final time to skip the output format setting.



**Note:** Now AWS CLI is ready to use.
