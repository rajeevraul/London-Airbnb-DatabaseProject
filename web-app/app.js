const express = require('express');
const app = express();
const port = 3000;
const bodyParser = require('body-parser');
const mysql = require('mysql');
const mustacheExpress = require('mustache-express');

// app.get('/', function (req, res) {
//     res.send('<h1>Hello, World!</h1>');
// });

app.listen(port, function () {
    console.log(`App listening at http://localhost:${port}.`);
});

app.engine('html', mustacheExpress());
app.set('view engine', 'html');
app.set('views', './templates');
app.use(bodyParser.urlencoded({ extended: true }));

var dbcon = mysql.createConnection({
    host: 'localhost',
    user: 'hmaguire',
    password: 'thegoat',
    database: 'london_airbnb'
})

function templateRenderer(template, res) {
    return function (error, results, fields) {
        if (error)
            throw error;
        res.render(template, { data: results });
    }
}

app.get('/', function (req, res) {
    dbcon.connect();
    
    // Question 1
    dbcon.query("SELECT n.neighbourhood, p.room_type, COUNT(*) AS count, AVG(pr.rating) AS average_rating, AVG(pr.price) AS average_price FROM property AS pr JOIN neighbourhoods AS n ON pr.neighbourhood_id = n.neighbourhood_id JOIN property_size AS p ON pr.size_id = p.size_id GROUP BY n.neighbourhood, p.room_type ORDER BY n.neighbourhood, count DESC;", templateRenderer('index', res));
    
    // Question 2
    // dbcon.query("WITH RankedProperties AS ( SELECT pr.property_id, pr.location, n.neighbourhood, pr.price, AVG(pr.rating) AS average_rating, SUM(pr.number_of_reviews_ltm) AS total_reviews, ROW_NUMBER() OVER (PARTITION BY pr.neighbourhood_id ORDER BY pr.price ASC, AVG(pr.rating) DESC, SUM(pr.number_of_reviews_ltm) DESC) AS row_num FROM property AS pr JOIN neighbourhoods AS n ON pr.neighbourhood_id = n.neighbourhood_id GROUP BY pr.property_id, pr.location, n.neighbourhood, pr.price HAVING total_reviews > 20 ) SELECT property_id, location, neighbourhood, price, average_rating, total_reviews FROM RankedProperties WHERE row_num <= 5;", templateRenderer('index', res));
    
    // Question 3
    // dbcon.query("SELECT h.host_id, h.host_name, h.calculated_host_listings_count AS host_listings_count, AVG(pr.rating) AS average_rating, AVG(pr.price) AS average_price FROM property AS pr JOIN neighbourhoods AS n ON pr.neighbourhood_id = n.neighbourhood_id JOIN hosts AS h ON pr.host_id = h.host_id JOIN property_size AS p ON pr.size_id = p.size_id GROUP BY h.host_id, h.host_name, h.calculated_host_listings_count HAVING h.calculated_host_listings_count > 1 ORDER BY h.host_name, h.calculated_host_listings_count;", templateRenderer('index', res));
    dbcon.end();
})