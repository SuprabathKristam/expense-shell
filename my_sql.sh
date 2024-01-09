MYSQL_PASSWORD=$1
if [ -z "$MYSQL_PASSWORD" ]; then
  echo "Input MySql Password is missing"
  exit 1
fi
source common.sh # Importing functions and variables from common.sh file
component=my_sql

Head "Disable default version of mysql"
dnf module disable mysql -y
Stat $?

Head "Setting mysql repo file"
cp mysql.repo /etc/yum.repos.d/mysql.repo
Stat $?

Head "Installing Mysql Server"
dnf install mysql-community-server -y
Stat $?

Head "Restarting mysqld service"
systemctl enable mysqld
systemctl start mysqld
Stat $?

Head "Setting default password"
mysql_secure_installation --set-root-pass ${MYSQL_PASSWORD=$1}
Stat $?