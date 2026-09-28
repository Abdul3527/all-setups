
#!/bin/bash

# Update system packages
sudo yum update -y

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/rpm-stable/jenkins.repo

# Import Jenkins repository key
sudo rpm --import \
https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key

# Upgrade packages
sudo yum upgrade -y

# Install Java 21
sudo yum install java-21-amazon-corretto -y

# Install Jenkins and Git
sudo yum install jenkins git -y

# Enable Jenkins service
sudo systemctl enable jenkins

# Start Jenkins
sudo systemctl start jenkins

# Check Jenkins status
sudo systemctl status jenkins --no-pager

# Configure temporary disk for /tmp
sudo mkdir -p /var/tmp_disk
sudo chmod 1777 /var/tmp_disk
sudo mount --bind /var/tmp_disk /tmp

# Make /tmp mount persistent
echo '/var/tmp_disk /tmp none bind 0 0' | sudo tee -a /etc/fstab

# Disable default temporary mount
sudo systemctl mask tmp.mount

# Check /tmp filesystem
df -h /tmp

# Restart Jenkins
sudo systemctl restart jenkins

# Verify Jenkins status
sudo systemctl status jenkins --no-pager
