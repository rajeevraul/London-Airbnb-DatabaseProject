USE london_airbnb;

DROP TABLE IF EXISTS listings;

CREATE TABLE listings (
  id varchar(255),
  Location varchar(255),
  Rating varchar(255),
  Bedrooms varchar(255),
  Beds varchar(255),
  Baths varchar(255),
  room_type varchar(255),
  price int,
  neighbourhood varchar(255),
  host_name varchar(255),
  host_id int,
  calculated_host_listings_count int,
  latitude float, 
  longitude float,
  minimum_nights int,
  number_of_reviews int,
  reviews_per_month float,
  number_of_reviews_ltm int,
  last_review varchar(255),
  availability_365 int
);


LOAD DATA INFILE '/home/coder/project/mid-term/listings/data/fmtd-listings.csv'
INTO TABLE listings
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;