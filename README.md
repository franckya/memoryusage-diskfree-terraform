# Collect Memory Usage and Available Disk Space using Terraform Script

This Terraform configuration allows you to collect memory usage and available disk space information from Linux servers. It utilizes the remote-exec provisioner to run commands on the servers and the null_resource resource to store the command output.

## How It Works

The `main.tf` configuration defines a `null_resource` with a `remote-exec` provisioner that executes two commands on the servers:

1. Collect memory usage: The command `free -m | grep Mem | awk '{print $3}' > /tmp/memory.txt` gathers memory usage information and stores it in the temporary file `/tmp/memory.txt`.

2. Collect available disk space: The command `df -h | grep /dev/xvda1 | awk '{print $4}' > /tmp/disk.txt` retrieves the available disk space and saves it in the temporary file `/tmp/disk.txt`.

The `null_resource` uses the `count` parameter to create multiple instances based on the number of servers specified in the `server_ips` variable. The `triggers` block captures the IP address of each server to be referenced in the inline commands and output values.

## Usage

1. Define the `server_ips` variable: Set the `server_ips` variable to contain the IP addresses of the servers you want to collect information from.

2. Set the `private_key_path` variable: Point the `private_key_path` variable to the path of the private key file used for SSH authentication to access the servers.

3. Apply the Terraform configuration: Execute `terraform apply` to apply the configuration and collect memory usage and disk space information from the servers.

Example:
```bash
terraform apply \
  -var 'server_ips=["1.2.3.4", "5.6.7.8"]' \
  -var 'private_key_path=/path/to/private/key'
```

4. Access the collected information: Retrieve the memory usage and disk space information using the `terraform output` command:

```bash
terraform output server_memory_usage
terraform output server_disk_space
```

The output will display the memory usage and disk space for each server as a list of strings.
