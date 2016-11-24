# ecr-dockercfg-refresh - Refresh Kubernetes ECR Docker Credentials

The ecr-dockercfg-refresh.sh script can be used to refresh docker credentials that are used by kubernetes to pull
images from a private ECR. You can use the [associated docker image](https://hub.docker.com/r/caseylucas/ecr-dockercfg-refresh/)
if you want to refresh the credentials by running a container under kubernetes.

## You probably don't need this

Using AWS ECR with kubernetes is
[natively supported by kubernetes](http://kubernetes.io/docs/user-guide/images/#using-aws-ec2-container-registry) if you
have the aws cloud provider enabled. If you are using kubernetes with the aws cloud provider enabled, you should just let
kubernetes do it's thing.

## If you do need this...
If you are not using the aws cloud provider plugin and still want to use a private AWS docker repo, then you'll need
to update the docker credentials at least every 12 hours in order to have kubernetes pull images.

You can run ecr-dockercfg-refresh.sh or just do it via a container that runs in kubernetes:

```
kubectl run --image=caseylucas/ecr-dockercfg-refresh:0.1 ecr-dockercfg-refresh
```

The script will create/refresh the token at startup then refresh every 5 hours (by default). After running, you should see a
secret created:
```
# kubectl get secrets
NAME                         TYPE                                  DATA      AGE
default-token-vm0dp          kubernetes.io/service-account-token   3         16d
us-east-1-ecr-registry-key   kubernetes.io/dockercfg               1         15h
```
Now, you should be able to
[use an imagePullSecret to pull containers](http://kubernetes.io/docs/user-guide/images/#referring-to-an-imagepullsecrets-on-a-pod).

If you want to change some settings (like how often to refresh the token), you'll want to create a kubernetes configuration file
that overrides some of the environment variables used by the script.

I have not tried it but it should be possible to run the script/container outside of AWS in order to use ECR, but you will need
to set the `AWS_ACCOUNT` and `AWS_REGION` environment variables and make sure that the AWS CLI is properly configured/authenticated.
