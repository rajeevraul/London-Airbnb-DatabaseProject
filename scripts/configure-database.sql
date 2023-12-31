DROP DATABASE IF EXISTS london_airbnb;
CREATE DATABASE london_airbnb;

USE london_airbnb;

DROP USER IF EXISTS 'hmaguire'@'%';
CREATE USER 'hmaguire'@'%' IDENTIFIED WITH mysql_native_password BY 'thegoat'; 
GRANT ALL ON london_airbnb.* TO 'hmaguire'@'%';
