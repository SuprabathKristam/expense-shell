MYSQL_PASSWORD=$1
if [ -z "$MYSQL_PASSWORD" ]; then
  echo "Input MySql Password is missing"
  return
fi

source common.sh # Importing functions and variables from commmon.sh file
component=backend

Head "Disable default version of NodJs"
dnf module disable nodejs -y &>>$log_file
Stat $?

Head "Enable NodeJs 18 version"
dnf module enable nodejs:18 -y &>>$log_file
Stat $?

Head "Installing NodeJs"
dnf install nodejs -y &>>$log_file
Stat $?

Head "Configuring backend service"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
Stat $?

Head "Adding Application user"
id expense &>>log_file
if [ "$?" -ne 0 ]; then
  useradd expense &>>$log_file
fi
Stat $?

App_Prereq "/app" # Added this function in common.sh with steps that are repeating in other
#Files also and using it here

Head "Downloading Application dependencies"
npm install &>>$log_file
Stat $?

Head "Reloading systemd and start backend service"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
Stat $?

Head "Installing  MySql Clinet"
dnf install mysql -y &>>$log_file
Stat $?

Head "Loading Schema"
mysql -h mysql-dev.kdevopspractice.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
Stat $?