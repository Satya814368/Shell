dnf install python3 gcc python3-devel -y

useradd roboshop

mkdir /app

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip /tmp/payment.zip

cd /app
pip3 install -r requirements.txt

[Unit]
Description=Payment Service

[Service]
User=root
WorkingDirectory=/app
Environment=CART_HOST=<CART-SERVER-IPADDRESS>
Environment=CART_PORT=8080
Environment=USER_HOST=<USER-SERVER-IPADDRESS>
Environment=USER_PORT=8080
Environment=AMQP_HOST=<RABBITMQ-SERVER-IPADDRESS>
Environment=AMQP_USER=roboshop
Environment=AMQP_PASS=roboshop123

ExecStart=/usr/local/bin/uwsgi --ini payment.ini
ExecStop=/bin/kill -9 $MAINPID
SyslogIdentifier=payment

[Install]
WantedBy=multi-user.target

systemctl daemon-reload

systemctl enable payment
systemctl start payment

