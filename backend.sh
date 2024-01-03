MYSQL_PASSWORD=$1
log_file=/tmp/expense.log

Head(){
  Head[36m$1\e[0m"
}
Head "Disable default version of NodJs"
dnf module disable nodejs -y &>>$log_file

Head "Enable NodeJs 18 version"
dnf module enable nodejs:18 -y &>>$log_file

Head "nstalling NodeJs"
dnf install nodejs -y &>>$log_file

Head "Configuring backend service"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

Head "Adding Application user"
useradd expense &>>$log_file

Head "Removing existing default app content"
rm -rf /app &>>$log_file

Head "Creating Application Directory"
mkdir /app &>>$log_file

Head "Downloading application content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file

Head "Extracting Application Content"
unzip /tmp/backend.zip &>>$log_file

Head "Downloading Application dependencies"
npm install &>>$log_file

Head "Reloading systemd and start backend service"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file

Head "Installing  MySql Clinet"
dnf install mysql -y &>>$log_file

Head "Loading Schema"
mysql -h mysql-dev.kdevopspractice.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file