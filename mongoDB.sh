[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
enabled=1
gpgcheck=0

dnf install mongodb-org -y

systemctl enable mongod
systemctl start mongod

systemctl restart mongod