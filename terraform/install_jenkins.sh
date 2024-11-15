#!/bin/bash
# Note: Changed the shebang to /bin/bash for better compatibility

echo "Starting Jenkins installation script..."
echo "Ensure you have added a security group with port 8080 open for 0.0.0.0/0 and that your instance has 4GB of memory."

# Move to the /opt directory
cd /opt || exit  # Ensure the script exits if /opt does not exist

# Installing essential utilities
echo "Installing essential utilities..."
sudo yum install -y wget vim tree unzip

# Installing Java 17
echo "Installing Java 17 (Amazon Corretto)..."
sudo yum install fontconfig java-17-openjdk
sudo yum install -y java-17-amazon-corretto
sudo yum install -y fontconfig  # Required font configuration package
java -version  # Verify the Java installation

# echo "Install Maven"
sudo yum install -y maven

# Installing the Jenkins key and repository
echo "Adding Jenkins repository and key..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Installing Jenkins
echo "Installing Jenkins..."
sudo yum install -y jenkins

# Starting and enabling Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Adding Jenkins user to the Docker group
sudo usermod -a -G docker jenkins

# Starting Docker service and ensuring it's enabled on boot
echo "Starting Docker service..."
sudo service docker start
sudo chkconfig docker on

# Verifying the Jenkins service status
echo "Verifying the Jenkins service status..."
sudo systemctl status jenkins

# Obtaining the initial admin password for Jenkins
echo "Obtaining the initial admin password for Jenkins..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Jenkins installation completed successfully."



# #!/bin/bash
# # Note: Changed the shebang to /bin/bash for better compatibility
# echo "This script will help you with the installation of Jenkins."
# echo "You will need to add a security group and open port 8080 with source set to 0.0.0.0/0."
# echo "You will need to launch an instance with 4GB of memory."
# echo "Do you want to continue with your Jenkins Installation?"
# echo "Enter 1 for yes and 2 for no."
# read -r response

# if [ "$response" -eq 1 ]; then
#     echo "Your installation will commence in a moment..."
#     sleep 1
#     cd /opt || exit  # Ensure the script exits if /opt does not exist

#     echo "Installing essential apps..."
#     sudo yum install -y wget vim tree unzip

#     echo "Installing Java..."
#     sudo yum install -y java-17-amazon-corretto  # Updated to Amazon Corretto for Amazon Linux
#     sudo yum install fontconfig java-17-openjdk
#     sleep 1
#     # List available Java versions
#     # sudo update-alternatives --config java
#     # Follow the prompts to select Java 11 (Amazon Corretto) as the default version.
#     java -version
#     sleep 1

#     echo "Installing the Jenkins key and repository..."
#     sleep 1
#     sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
#     sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#     echo "Installing Jenkins..."
#     sudo yum install -y jenkins
#     echo "Starting and enabling the Jenkins service..."
#     sudo systemctl start jenkins
#     sudo systemctl enable jenkins
#     sudo usermod -a -G docker jenkins
#     echo "Verifying the Jenkins service status..."
#     sudo systemctl status jenkins
#     sudo chkconfig jenkins on
#     echo "Start Docker & Jenkins services"
#     sudo service docker start
#     sudo service jenkins start
#     echo "Obtaining the initial admin password for Jenkins..."
#     sudo cat /var/lib/jenkins/secrets/initialAdminPassword
# else
#     echo "An instance with 4GB of memory, such as t2.medium, will be sufficient for this server."
# fi




# #!/bin/bash
# sudo yum -y update

# echo "Install Java JDK 8"
# sudo yum remove -y java
# sudo yum install -y java-1.8.0-openjdk

# echo "Install Maven"
# sudo yum install -y maven 

# echo "Install git"
# sudo yum install -y git

# echo "Install Docker engine"
# sudo yum update -y
# sudo yum install docker -y
# sudo sudo chkconfig docker on

# echo "Install Jenkins"

# sudo wget -O /etc/yum.repos.d/jenkins.repo \
#     https://pkg.jenkins.io/redhat-stable/jenkins.repo
# cd /etc/yum.repos.d/
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# # Add required dependencies for the jenkins package
# sudo yum install fontconfig java-17-openjdk
# sudo yum -y install jenkins
# sudo usermod -a -G docker jenkins
# sudo chkconfig jenkins on
# echo "Start Docker & Jenkins services"
# # start docker
# sudo service docker start
# # enable the Jenkins service to start at boot with the command
# sudo systemctl enable jenkins
# #start the Jenkins service
# sudo systemctl start jenkins
# # check the status of the Jenkins service 
# sudo systemctl status jenkins
