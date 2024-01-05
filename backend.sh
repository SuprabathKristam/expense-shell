MYSQL_PASSWORD=$1

source common.sh # Importing functions and variables from commmon.sh file
component=backend

Head "Disable default version of NodJs"
dnf module disable nodejs -y &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "Enable NodeJs 18 version"
dnf module enable nodejs:18 -y &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "Installing NodeJs"
dnf install nodejs -y &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "Configuring backend service"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "Adding Application user"
useradd expense &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

App_Prereq "/app" # Added this function in common.sh with steps that are repeating in other
#Files also and using it here

Head "Downloading Application dependencies"
npm install &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "Reloading systemd and start backend service"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "Installing  MySql Clinet"
dnf install mysql -y &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "Loading Schema"
mysql -h mysql-dev.kdevopspractice.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
if [ "$?" -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi