resource "null_resource" "server_info" {
  count = length(var.server_ips)
  triggers = {
    server_ip = var.server_ips[count.index]
  }
  provisioner "remote-exec" {
    connection {
      host        = trimspace(var.server_ips[count.index])
      user        = "root"
      private_key = file(var.private_key_path)
    }
    inline = [
      "free -m | grep Mem | awk '{print $3}' > /tmp/memory.txt",
      "df -h | grep /dev/xvda1 | awk '{print $4}' > /tmp/disk.txt",
    ]
  }
}

output "server_memory_usage" {
  value = [for s in null_resource.server_info: file(format("/tmp/memory.txt", s.triggers.server_ip))]
}

output "server_disk_space" {
  value = [for s in null_resource.server_info: file(format("/tmp/disk.txt", s.triggers.server_ip))]
}
