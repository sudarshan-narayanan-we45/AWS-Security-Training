## CloudMapper

>CloudMapper helps you analyze your Amazon Web Services (AWS) environments. The original purpose was to generate network diagrams and display them in your browser. It now contains much more functionality.


##### Step 1:

* Open Terminal

##### Step 2:

*  **cd** into  `/home/we45/AWS-Security-Training/cloud_mapper/lab`

    ```commandline
    cd /home/we45/AWS-Security-Training/cloud_mapper/lab
    ```

##### Step 3:

* Run `pipenv shell` to ativate the python virtualenv


##### Step 4:

* Run `python cloudmapper.py prepare --config config.json.demo --account demo`
* Run `python cloudmapper.py webserver`

This will run a local webserver at http://127.0.0.1:8000/


##### Step 5:

Open browser and run `http://127.0.0.1:8000/` and check the details
