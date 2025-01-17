`docker-compose up --build`
```
docker-compose run spark bash
python /app/sample.py
```
http://localhost:8080/ to see local spark UI


to runs on dataproc serverless:
```
# build image and store in repository
gcloud builds submit --region=us-east1     --tag us-east1-docker.pkg.dev/ryanchong-playground/ryan-dataproc-test/ryan-test-dataproc-local:0.0.1
# submit container to dataproc batchest
gcloud dataproc batches submit pyspark sample.py --region=us-east1 --container-image='us-east1-docker.pkg.dev/ryanchong-playground/ryan-dataproc-test/ryan-test-dataproc-local:0.0.1' --deps-bucket=ryanchong-spark-testing
```
