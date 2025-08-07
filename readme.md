export HCLOUD_TOKEN=yadayadayadayada, goes instead of hetzner_token in config

fill the config 

hetzner-k3s create --config cluster-config.yaml | tee cluster-create.log

Fun fact:I had id_rsa pass-keyed somehow, this was preventing me from accessing server. Make sure yours is without password
Fun fact2: dont forget to give 600 to the key

maxsauce@192 ~/.ssh$ ssh-keygen -lf ~/.ssh/id_ecdsa.pub                                                                                                                                                     130 ↵  
521 SHA256:jL49R6RhMSlJ5O2tzJRZTWfEFPzcqTZpiIhaR5fy7S8 maxsauce@192.168.1.7 (ECDSA)
maxsauce@192 ~/.ssh$ ssh-keygen -E md5 -lf ~/.ssh/id_ecdsa.pub                                                                                                                                                     
521 MD5:e2:6a:33:55:65:1f:83:24:aa:c0:02:e0:81:be:b7:b9 maxsauce@192.168.1.7 (ECDSA)
Fingerprint. was different that the one in the cloud because i did not recreate whole project and thus did not delete the key conpletely.

After completion, i've got kubeconfig and kubeconfig cloud
KUBECONFIG=~/.kube/config:./kubeconfig kubectl config view --flatten > /tmp/merged-kubeconfig
removed one unfinished cluster declaration
maxsauce@192 ~/.ssh$ mv /tmp/merged-kubeconfig ~/.kube/config
my cluster showed up, now switch to it's context.

k9s, :events, and i see this `Node cloud-master1 event: Registered Node cloud-master1 in Controller`, which means cluster is successfully deployed.