# !/bin/bash
# assign variables
ACTION=${1}
# assign version
version="1.0.0"

function system_setup(){

# Update all system packages
sudo yum update -y
# Install the Nginx software packageo
sudo amazon-linux-extras install nginx1.12 -y
# Configure nginx to automatically start at system boot up.o
sudo chkconfig nginx on
# Copy the website documents from s3 to the web document root directory
# (/usr/share/nginx/html).
sudo aws s3 cp s3://glendasp-assignment-3/index.html /usr/share/nginx/html/index.
# Start the Nginx service.
sudo service nginx start
}

#If the user starts the script with a -r or --remove argument, the script will perform the following steps
#Stop the Nginx service. $ sudo service nginx stop
#Delete the files in the website document root directory (/usr/share/nginx/html).
#Uninstall the Nginx software package(yum remove nginx -y).


function display_version() {
echo  "$version"
}

function remove_nginx() {
sudo service nginx stop #Stop the Nginx service.
sudo rm  /usr/share/nginx/html/* #Delete the files in the website document root directory
sudo yum remove nginx -y  #Uninstall the Nginx software package
}

function display_help(){

cat << EOF
Usage: ${0} {-h|--help|-v|--version|-r|--remove}

OPTIONS:
	-h | --helpDisplay 	Display the command help
	-v | --version		Display  script's version
	-r | --remove		Remove  nginx

Examples:
	Display help:
		$ ${0} -h
	Display version
		$ ${0} -v
	Remove nginx
		$ ${0} -r
EOF
}

case "$ACTION" in
	"")
		system_setup
		;;
	-h|--help)
		display_help
		;;
	-v|--version)
		display_version
		;;
	-r|--remove)
		remove_nginx
		;;
	*)
	echo "Usage ${0} {-h|-v|-r}"
	exit 1 
esac
