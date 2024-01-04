
log_file=/tmp/expense.log

Head(){
  echo -e "\e[36m$1\e[0m"
}

App_Prereq(){
  DIR=$1
Head "Removing existing default app content"
rm -rf /app &>>$log_file
echo $?

Head "Creating Application Directory"
mkdir /app &>>$log_file
echo $?

Head "Downloading application content"
curl -o /tmp/${backend}.zip https://expense-artifacts.s3.amazonaws.com/${backend}.zip &>>$log_file
echo $?
cd /app

Head "Extracting Application Content"
unzip /tmp/{backend}.zip &>>$log_file
echo $?
}