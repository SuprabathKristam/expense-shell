echo -e "\e[36mDisable default version of NodJs\e[0m"
dnf module disable nodejs -y > /tmp/expense.log

echo -e "\e[36m Enable NodeJs 18 version\e[0m"
dnf module enable nodejs:18 -y > /tmp/expense.log

echo -e "\e[36m Installing NodeJs\e[0m"
dnf install nodejs -y > /tmp/expense.log

echo -e "\e[36m Configuring backend service file\e[0m"
cp backend.service /etc/systemd/system/backend.service > /tmp/expense.log

echo -e "\e[36m Adding Application user\e[0m"
useradd expense > /tmp/expense.log

echo -e "\e[36m Removing existing default app content\e[0m"
rm -rf /app > /tmp/expense.log

echo -e "\e[36m Creating Application Directory\e[0m"
mkdir /app > /tmp/expense.log

echo -e "\e[36m Downloading application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip > /tmp/expense.log
cd /app > /tmp/expense.log

echo -e "\e[36m Extracting Application Content\e[0m"
unzip /tmp/backend.zip > /tmp/expense.log

echo -e "\e[36m Downloading Application dependencies\e[0m"
npm install > /tmp/expense.log

echo -e "\e[36m Reloading systemd and start backend service\e[0m"
systemctl daemon-reload > /tmp/expense.log
systemctl enable backend > /tmp/expense.log
systemctl restart backend > /tmp/expense.log

echo -e "\e[36m Installing  MySql Clinet\e[0m"
dnf install mysql -y > /tmp/expense.log

echo -e "\e[36m Loading Schema\e[0m"
mysql -h mysql-dev.kdevopspractice.online -uroot -pExpenseApp@1 < /app/schema/backend.sql > /tmp/expense.log