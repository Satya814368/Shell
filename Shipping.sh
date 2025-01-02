dnf install maven -y

useradd roboshop

mkdir /app

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip

cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

[Unit]
Description=Shipping Service

[Service]
User=roboshop
Environment=CART_ENDPOINT=<CART-SERVER-IPADDRESS>:8080
Environment=DB_HOST=<MYSQL-SERVER-IPADDRESS>
ExecStart=/bin/java -jar /app/shipping.jar
SyslogIdentifier=shipping

[Install]
WantedBy=multi-user.target

systemctl daemon-reload

systemctl enable shipping
systemctl start shipping

dnf install mysql -y

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql

systemctl restart shipping