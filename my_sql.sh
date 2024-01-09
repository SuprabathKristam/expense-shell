MYSQL_PASSWORD=$1
if [ -z "$MYSQL_PASSWORD" ]; then
  echo "Input MySql Password is missing"
  exit 1
fi
source common.sh # Importing functions and variables from common.sh file
component=my_sql

Head "Disable default version of mysql"
dnf module disable mysql -y &>>$log_file
Stat $?

Head "Setting mysql repo file"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
Stat $?

Head "Installing Mysql Server"
dnf install mysql-community-server -y &>>$log_file
Stat $?

Head "Restarting mysqld service"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
Stat $?

Head "Setting default password"
mysql_secure_installation --set-root-pass ${MYSQL_PASSWORD=$1} &>>$log_file
Stat $?