
log_file=/tmp/expense.log

Head(){
  echo -e "\e[36m$1\e[0m"
}

App_Prereq(){
  DIR=$1
Head "Removing existing default app content"
rm -rf /app &>>$log_file
Stat $?

Head "Creating Application Directory"
mkdir /app &>>$log_file
Stat $?

Head "Downloading application content"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
Stat $?
cd /app

Head "Extracting Application Content"
unzip /tmp/${component}.zip &>>$log_file
Stat $?
}

Stat(){
  if [ "$1" -eq 0 ];then
    echo SUCCESS
  else
    echo FAILURE
    exit 1
  fi
}