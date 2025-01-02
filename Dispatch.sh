dnf install golang -y

useradd roboshop

mkdir /app

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

cd /app
go mod init dispatch
go get
go build

[Unit]
Description = Dispatch Service
[Service]
User=roboshop
Environment=AMQP_HOST=RABBITMQ-IP
Environment=AMQP_USER=roboshop
Environment=AMQP_PASS=roboshop123
ExecStart=/app/dispatch
SyslogIdentifier=dispatch

[Install]
WantedBy=multi-user.target

systemctl daemon-reload

systemctl enable dispatch
systemctl start dispatch