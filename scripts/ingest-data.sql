USE london_airbnb;

DELETE FROM neighbourhoods;
INSERT INTO neighbourhoods (neighbourhood)
  SELECT DISTINCT neighbourhood
  FROM listings;


DELETE FROM hosts;
INSERT INTO hosts(host_id, host_name, calculated_host_listings_count)
  SELECT DISTINCT host_id, host_name, calculated_host_listings_count
  FROM listings;

DELETE FROM property_size;
INSERT INTO property_size(room_type, bedrooms, beds, baths)
  SELECT DISTINCT l.room_type, REPLACE(SUBSTRING_INDEX(TRIM(l.bedrooms), ' ', 1), 'Studio', '1'), l.beds, l.baths
  FROM listings as l;


DELETE FROM property;
INSERT INTO property(property_id, Location, price, rating, latitude, longitude , minimum_nights ,availability_365,last_review,no_of_reviews  ,number_of_reviews_ltm  ,neighbourhood_id ,host_id,size_id)
  SELECT p.id, p.Location, p.price, REPLACE(p.rating, 'New', '1'), p.latitude, p.longitude , p.minimum_nights , p.availability_365, p.last_review, p.number_of_reviews, p.number_of_reviews_ltm, 
  n.neighbourhood_id, h.host_id, s.size_id 
  FROM listings as p LEFT JOIN neighbourhoods as n ON p.neighbourhood=n.neighbourhood
  LEFT JOIN hosts as h ON p.host_id=h.host_id
  LEFT JOIN property_size as s
  ON p.room_type=s.room_type AND REPLACE(SUBSTRING_INDEX(TRIM(p.bedrooms), ' ', 1), 'Studio', '1')=s.bedrooms AND p.beds = s.beds AND p.baths = s.baths;