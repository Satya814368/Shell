dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip

cd /app
npm install

[Unit]
Description = User Service
[Service]
User=roboshop
Environment=MONGO=true
Environment=REDIS_URL='redis://<REDIS-IP-ADDRESS>:6379'
Environment=MONGO_URL="mongodb://<MONGODB-SERVER-IP-ADDRESS>:27017/users"
ExecStart=/bin/node /app/server.js
SyslogIdentifier=user

[Install]
WantedBy=multi-user.target

systemctl daemon-reload

systemctl enable user
systemctl start user