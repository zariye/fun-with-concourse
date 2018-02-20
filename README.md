Please note this project is just a spike to play a bit around with concourse annd a simple node app.

It does not follow ANY security regulations, please use it on your own risk.

To deploy with credentials: fly -t test set-pipeline --load-vars-from credentials.yml -p smoke -c pipeline.yml

