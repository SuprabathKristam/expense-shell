log_file=/tmp/expense.log

Head(){
  echo -e "\e[36m$1\e[0m"
}

Head "Installing Nginx"
dnf install nginx -y &>>$log_file
echo $?

Head "Copying expense config"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

Head "Deleting ol/default content"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

Head "Downloading app content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?

cd /usr/share/nginx/html

Head "Extracting the application content"
unzip /tmp/frontend.zip &>>$log_file
echo $?

Head "Enabling and restarting nginx"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?