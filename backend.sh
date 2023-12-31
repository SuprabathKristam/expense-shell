echo -e "\e[36mDisable default version of NodJs\e[0m"
dnf module disable nodejs -y > /tmp/expense.log

echo -e "\e[36mEnable NodeJs 18 version\e[0m"
dnf module enable nodejs:18 -y > /tmp/expense.log

echo -e "\e[36mInstalling NodeJs\e[0m"
dnf install nodejs -y > /tmp/expense.log

echo -e "\e[36mConfiguring backend service file\e[0m"
cp backend.service /etc/systemd/system/backend.service > /tmp/expense.log

echo -e "\e[36mAdding Application user\e[0m"
useradd expense > /tmp/expense.log

echo -e "\e[36mRemoving existing default app content\e[0m"
rm -rf /app > /tmp/expense.log

echo -e "\e[36mCreating Application Directory\e[0m"
mkdir /app > /tmp/expense.log

echo -e "\e[36mDownloading application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip > /tmp/expense.log
cd /app > /tmp/expense.log

echo -e "\e[36mExtracting Application Content\e[0m"
unzip /tmp/backend.zip > /tmp/expense.log

echo -e "\e[36mDownloading Application dependencies\e[0m"
npm install > /tmp/expense.log

echo -e "\e[36mReloading systemd and start backend service\e[0m"
systemctl daemon-reload > /tmp/expense.log
systemctl enable backend > /tmp/expense.log
systemctl restart backend > /tmp/expense.log

echo -e "\e[36mInstalling  MySql Clinet\e[0m"
dnf install mysql -y > /tmp/expense.log

echo -e "\e[36mLoading Schema\e[0m"
mysql -h mysql-dev.kdevopspractice.online -uroot -pExpenseApp@1 < /app/schema/backend.sql > /tmp/expense.log