CREATE DATABASE IF NOT EXISTS london_airbnb;

USE london_airbnb;

DROP TABLE IF EXISTS property;
DROP TABLE IF EXISTS neighbourhoods;
DROP TABLE IF EXISTS hosts;
DROP TABLE IF EXISTS property_size;

CREATE TABLE neighbourhoods (
    neighbourhood_id INT PRIMARY KEY AUTO_INCREMENT,
    neighbourhood VARCHAR(255) NOT NULL
);

CREATE TABLE hosts (
    host_id varchar(255) PRIMARY KEY,
    host_name VARCHAR(255) NOT NULL,
    calculated_host_listings_count INT NOT NULL
);

CREATE TABLE property_size (sho
    size_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(255),
    bedrooms FLOAT,
    beds varchar(255),
    baths varchar(255)
);

CREATE TABLE property (
    property_id VARCHAR(255) PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL,
    rating FLOAT NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    minimum_nights INT NOT NULL,
    availability_365 INT NOT NULL,
    last_review VARCHAR(255),
    no_of_reviews INT NOT NULL,
    reviews_per_month FLOAT,
    number_of_reviews_ltm INT NOT NULL,
    neighbourhood_id INT,
    host_id varchar(255),
    size_id INT,
    FOREIGN KEY (neighbourhood_id) REFERENCES neighbourhoods(neighbourhood_id),
    FOREIGN KEY (host_id) REFERENCES hosts(host_id),
    FOREIGN KEY (size_id) REFERENCES property_size(size_id)
);