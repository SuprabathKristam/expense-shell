echo -e "\e[36mDisable default version of NodJs\e[0m"
dnf module disable nodejs -y > /temp/expense.log

echo -e "\e[36m Enable NodeJs 18 version\e[0m"
dnf module enable nodejs:18 -y > /temp/expense.log

echo -e "\e[36m Installing NodeJs\e[0m"
dnf install nodejs -y > /temp/expense.log

echo -e "\e[36m Configuring backend service file\e[0m"
cp backend.service /etc/systemd/system/backend.service > /temp/expense.log

echo -e "\e[36m Adding Application user\e[0m"
useradd expense > /temp/expense.log

echo -e "\e[36m Removing existing default app content\e[0m"
rm -rf /app > /temp/expense.log

echo -e "\e[36m Creating Application Directory\e[0m"
mkdir /app > /temp/expense.log

echo -e "\e[36m Downloading application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip > /temp/expense.log
cd /app > /temp/expense.log

echo -e "\e[36m Extracting Application Content\e[0m"
unzip /tmp/backend.zip > /temp/expense.log

echo -e "\e[36m Downloading Application dependencies\e[0m"
npm install > /temp/expense.log

echo -e "\e[36m Reloading systemd and start backend service\e[0m"
systemctl daemon-reload > /temp/expense.log
systemctl enable backend > /temp/expense.log
systemctl restart backend > /temp/expense.log

echo -e "\e[36m Installing  MySql Clinet\e[0m"
dnf install mysql -y > /temp/expense.log

echo -e "\e[36m Loading Schema\e[0m"
mysql -h mysql-dev.kdevopspractice.online -uroot -pExpenseApp@1 < /app/schema/backend.sql > /temp/expense.log