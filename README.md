
Docker Symfony Contact form
==============

### What's inside ?

| CONTAINER | NOTES |
|--|--|
| **PHP 7.2** | enabled |
| **NGINX 1.12** | enabled |
| **MYSQL 5.7** | enabled |

### BUILD AND START PROJECT
    make start
###BACKOFFICE: `http://localhost:80/admin`
```
login: ahmedbhs123@gmail.com
password: password
```
### Generation doctrine diff
    make db-diff
### Launch doctrine migrations
    make db-migrate
### STOP PROJECT
    make stop
### LOAD FIXTURES
    make db-fixtures
###     

## ENV VARIABLES 
```
##Symfony application's path (absolute or relative)
SYMFONY_APP_PATH=./
##MySQL
MYSQL_PASSWORD=project
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=project
MYSQL_USER=project
 ```
### phpMyAdmin 

A tool like MySQL Workbench would be better but if you really want it uncomment the **phpmyadmin section** in the *docker-compose.yml* file.

    http://localhost:8080
