## Amazon KMS

>


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab
    ```

##### Step 3:

* Run `pipenv shell` to activate the virtualenv
    
    ```commmandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab# pipenv shell
    Creating a virtualenv for this project...
    Pipfile: /home/vagrant/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab/Pipfile
    Using /usr/bin/python (2.7.12) to create virtualenv...
    â ´ Creating virtual environment...Already using interpreter /usr/bin/python
    New python executable in /home/vagrant/.local/share/virtualenvs/lab-yVuPAqs0/bin/python
    Installing setuptools, pip, wheel...
    done.
    
    OK Successfully created virtual environment! 
    Virtualenv location: /home/vagrant/.local/share/virtualenvs/lab-yVuPAqs0
    Launching subshell in virtual environment...
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab#  . /home/vagrant/.local/share/virtualenvs/lab-yVuPAqs0/bin/activate
    (lab) root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab#
    ```

##### Step 4:

* Run `pipenv install`

    ```commandline
    (lab) root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab# pipenv install
    /usr/local/lib/python2.7/dist-packages/pipenv/patched/notpip/_vendor/requests/__init__.py:83: RequestsDependencyWarning: Old version of cryptography ([1, 2, 3]) may cause slowdown.
      warnings.warn(warning, RequestsDependencyWarning)
    Installing dependencies from Pipfile.lock (f45f4d)...
      ð   ââââââââââââââââââââââââââââââââ 11/11 â 00:00:17
    
    ``` 

##### Step 5:

* **Data Encryption**

* Run `python kms_data_encryption.py`

    ````commandline
    
    (lab) root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab# python kms_data_encryption.py 
    [+] Generated new Customer Master Key (CMK) with Key ID: 2c36f800-3cde-406c-bbce-dfc96af174dd
    [+] Generated Data new Key with Key ID: arn:aws:kms:us-east-1:358174707935:key/2c36f800-3cde-406c-bbce-dfc96af174dd
    [+] Generated ciphertext: naJjSwFUlT3H0MUsGZYJDg==.ecMAdB1K3TRygraWLhAfkuwmy+3iR1SSl8jvJF4c6iQ=
    [+] The reversed plaintext is: "Hello from we45"
    (lab) root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab# 
    
    ````


##### Step 6:

* **CMK Encryption**

* Run `python kms_cmk_encryption.py`
    
    ````commandline
    
    (lab) root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab# python kms_cmk_encryption.py 
    [+] Generated new Customer Master Key (CMK) with Key ID: c9141584-4073-478a-b278-77868c85bf3d
    [+] Generated Data new Key with Key ID: arn:aws:kms:us-east-1:358174707935:key/c9141584-4073-478a-b278-77868c85bf3d
    [+] This is the encrypted ciphertext: AQICAHhz+B0PfKa0SrfhCovogmbBTW7ZuovrPJAEnwyCbxdECQEiVecknHxYTUkaf4L/EfPlAAAAaTBnBgkqhkiG9w0BBwagWjBYAgEAMFMGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQM7TneJdYhWbtSBpf0AgEQgCYU+YL7YOzyMkpXHfU/z94IjI9gJHHHsv2Jji0P4lFBJJC3TFFt0Q==
    [+] This is the plaintext: Hello World
    ````


##### Step 7:

* Run `deactivate` to exit from the virtualenv
    
    ```commandline
    (lab) root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab# deactivate
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/kms/data_encryption/lab#
    ```
