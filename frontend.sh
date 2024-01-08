source common.sh # Importing functions and variables from commmon.sh file
component=frontend
Head "Installing Nginx"
dnf install nginx -y &>>$log_file
Stat $?

Head "Copying expense config"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
Stat $?

App_Prereq "/usr/share/nginx/html" # Added this function in common.sh with steps that are repeating in other
#Files also and using it here

Head "Enabling and restarting nginx"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
Stat $?