## Configuring AWS-Command Line Interface (CLI)
>Using AWS CLI we can control multiple AWS Services from 
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

We should provide our **AWS Access Key**, **AWS Secret KEY** and **Region** to configure AWS CLI

* Run `aws configure`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/cli# aws configure
AWS Access Key ID [****************AFLQ]: 
AWS Secret Access Key [****************V4LV]: 
Default region name [us-east-1]: 
Default output format [json]: 
```

This command is interactive and prompts you to enter additional information. Enter your Access Key ID, Secret Access Key, Region Name and skip the Output Format using the ENTER Key allowing it to take the default value.



**Note:**  AWS CLI is now ready to use.
