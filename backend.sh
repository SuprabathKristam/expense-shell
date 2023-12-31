echo Disable default version of NodJs
dnf module disable nodejs -y

echo Enable NodeJs 18 version
dnf module enable nodejs:18 -y

echo Installing NodeJs
dnf install nodejs -y

echo Configuring backend service file
cp backend.service /etc/systemd/system/backend.service

echo Adding Application user
useradd expense

echo Removing existing default app content
rm -rf /app

echo Creating Application Directory
mkdir /app

echo Downloading application content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo Extracting Application Content
unzip /tmp/backend.zip

echo Downloading Application dependencies
npm install

echo reloading systemd and start backend service
systemctl daemon-reload
systemctl enable backend
systemctl restart backend

echo install MySql Clinet
dnf install mysql -y

echo loading Schema
mysql -h mysql-dev.kdevopspractice.online -uroot -pExpenseApp@1 < /app/schema/backend.sql