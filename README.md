# docker-steampipe
Custom Steampipe Docker Image

### Sample command

```shell
docker run \
-p 9193:9193 \
-p 9194:9194 \
-e STEAMPIPE_DATABASE_PASSWORD=postgres \
-e AWS_ACCESS_KEY_ID="<AWS_ACCESS_KEY_ID>" \
-e AWS_SECRET_ACCESS_KEY="<AWS_SECRET_ACCESS_KEY>" \
-v <path>/kubeconfig:/home/steampipe/.kube/config \
-e DASHBOARD=steampipe-mod-kubernetes-insights \
ripper1:5000/steampipe:latest
```

