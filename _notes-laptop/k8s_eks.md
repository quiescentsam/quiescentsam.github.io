https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html


### install Kubectl

```shell script
bash-3.2$ curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/darwin/amd64/kubectl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 55.2M  100 55.2M    0     0  1095k      0  0:00:51  0:00:51 --:--:-- 2129k
bash-3.2$ ls -lart
total 115032
-rw-r--r--   1 sisa0003  staff       541 Jul  7 14:47 setupmac.md
drwxr-xr-x  40 sisa0003  staff      1280 Jul  7 14:47 ..
-rw-r--r--   1 sisa0003  staff        91 Jul  7 14:50 k8s_eks.md
drwxr-xr-x   5 sisa0003  staff       160 Jul  7 14:52 .
-rw-r--r--   1 sisa0003  staff  57903216 Jul  7 14:53 kubectl
bash-3.2$ curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/darwin/amd64/kubectl.sha256
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    73  100    73    0     0     68      0  0:00:01  0:00:01 --:--:--    68
bash-3.2$ openssl sha1 -sha256 kubectl
SHA256(kubectl)= 6e8439099c5a7d8d2f8f550f2f04301f9b0bb229a5f7c56477743a2cd11de2aa
bash-3.2$ cat kubectl.sha256 
6e8439099c5a7d8d2f8f550f2f04301f9b0bb229a5f7c56477743a2cd11de2aa kubectl
bash-3.2$ chmod +x ./kubectl
bash-3.2$ mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
bash-3.2$ kubectl version --short --client
Client Version: v1.16.6-beta.0
bash-3.2$ ls -alrt
total 115040
-rw-r--r--   1 sisa0003  staff       541 Jul  7 14:47 setupmac.md
drwxr-xr-x  40 sisa0003  staff      1280 Jul  7 14:47 ..
-rw-r--r--   1 sisa0003  staff        91 Jul  7 14:50 k8s_eks.md
-rwxr-xr-x   1 sisa0003  staff  57903216 Jul  7 14:53 kubectl
drwxr-xr-x   6 sisa0003  staff       192 Jul  7 14:54 .
-rw-r--r--   1 sisa0003  staff        73 Jul  7 14:54 kubectl.sha256
bash-3.2$ rm -rf kubectl kubectl.sha256
bash-3.2$ kubectl version --short --client
Client Version: v1.16.6-beta.0
bash-3.2$ 

```


### aws-iam-authenticator

This step is not needed for higher version of the AWS cli
https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html


### download the cluster config

(base) sisa0003@mymac ~ % aws eks --region us-east-1 update-kubeconfig --name CLUSTER_NAME
Added new context arn:aws:eks:us-east-1:xxxxxxxx:cluster/CLUSTER_NAME to /Users/sisa0003/.kube/config