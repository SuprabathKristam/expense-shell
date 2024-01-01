MYSQL_PASSWORD=$1
log_file=/tmp/expense.log

echo -e "\e[36mDisable default version of NodJs\e[0m"
dnf module disable nodejs -y &>>$log_file

echo -e "\e[36mEnable NodeJs 18 version\e[0m"
dnf module enable nodejs:18 -y &>>$log_file

echo -e "\e[36mInstalling NodeJs\e[0m"
dnf install nodejs -y &>>$log_file

echo -e "\e[36mConfiguring backend service file\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo -e "\e[36mAdding Application user\e[0m"
useradd expense &>>$log_file

echo -e "\e[36mRemoving existing default app content\e[0m"
rm -rf /app &>>$log_file

echo -e "\e[36mCreating Application Directory\e[0m"
mkdir /app &>>$log_file

echo -e "\e[36mDownloading application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file

echo -e "\e[36mExtracting Application Content\e[0m"
unzip /tmp/backend.zip &>>$log_file

echo -e "\e[36mDownloading Application dependencies\e[0m"
npm install &>>$log_file

echo -e "\e[36mReloading systemd and start backend service\e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file

echo -e "\e[36mInstalling  MySql Clinet\e[0m"
dnf install mysql -y &>>$log_file

echo -e "\e[36mLoading Schema\e[0m"
mysql -h mysql-dev.kdevopspractice.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file