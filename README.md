# memoryusage-diskfree-terraform
collect memory usage and available disk space using terraform script


To collect memory usage and available disk space on Linux servers using Terraform, you can use the remote-exec provisioner to run commands on the servers and the null_resource resource to store the output of those commands.

The main.tf configuration defines a null_resource with a remote-exec provisioner that runs two commands on the servers: one to collect the memory usage and one to collect the available disk space. The output of these commands is stored in temporary files on the servers.

The null_resource resource has a count parameter that specifies the number of instances to create, and a triggers block that stores the IP address of each server. This allows you to reference the IP address of each server in the inline commands and the output values.

The configuration also defines two output values, server_memory_usage and server_disk_space, that retrieve the contents of the temporary files on the servers and store them as a list of strings.

To use this configuration, you will need to define a variable server_ips that contains the IP addresses of the servers, and a variable private_key_path that points to the private key file used to ssh into the servers.

You can then use the terraform apply command to apply the configuration and collect the memory usage and disk space information from the servers.

```
terraform apply \
  -var 'server_ips=["1.2.3.4", "5.6.7.8"]' \
  -var 'private_key_path=/path/to/private/key'
```

You can access the collected information by running the terraform output command:

```
terraform output server_memory_usage
terraform output server_disk_space

```
This will print the memory usage and disk space for each server as a list of strings.

You can use this information in your Terraform configuration to make decisions, such as scaling up or down the number of servers based on the available resources.
