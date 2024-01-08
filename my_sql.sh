MYSQL_PASSWORD=$1
if[ -z "$MYSQL_PASSWORD" ]; then
  echo "Input MySql Password is missing"
  exit 1
fi
source common.sh # Importing functions and variables from commmon.sh file

dnf module disable mysql -y
cp mysql.repo /etc/yum.repos.d/mysql.repo
dnf install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld
mysql_secure_installation --set-root-pass ${MYSQL_PASSWORD=$1} 