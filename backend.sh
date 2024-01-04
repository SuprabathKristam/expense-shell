MYSQL_PASSWORD=$1

source common.sh # Importing functions and variables from commmon.sh file

Head "Disable default version of NodJs"
dnf module disable nodejs -y &>>$log_file
echo $?

Head "Enable NodeJs 18 version"
dnf module enable nodejs:18 -y &>>$log_file
echo $?

Head "nstalling NodeJs"
dnf install nodejs -y &>>$log_file
echo $?

Head "Configuring backend service"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

Head "Adding Application user"
useradd expense &>>$log_file
echo $?

Head "Removing existing default app content"
rm -rf /app &>>$log_file
echo $?

Head "Creating Application Directory"
mkdir /app &>>$log_file
echo $?

Head "Downloading application content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
echo $?
cd /app

Head "Extracting Application Content"
unzip /tmp/backend.zip &>>$log_file
echo $?

Head "Downloading Application dependencies"
npm install &>>$log_file
echo $?

Head "Reloading systemd and start backend service"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
echo $?

Head "Installing  MySql Clinet"
dnf install mysql -y &>>$log_file
echo $?

Head "Loading Schema"
mysql -h mysql-dev.kdevopspractice.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
echo $?