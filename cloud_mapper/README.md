## CloudMapper

>CloudMapper helps you analyze your Amazon Web Services (AWS) environments. The original purpose was to generate network diagrams and display them in your browser. It now contains much more functionality.


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/cloud_mapper/lab`

    ```commandline
    cd /home/vagrant/Desktop/Labs/AWS-Security-Training/cloud_mapper/lab
    ```

##### Step 3:

* Run `pipenv shell` to activate the python virtualenv


##### Step 4:

* Run `python cloudmapper.py prepare --config config.json.demo --account demo`
* Run `python cloudmapper.py webserver`

This will run a local webserver on http://127.0.0.1:8000/


##### Step 5:

Open browser and access `http://127.0.0.1:8000/` to check the details
