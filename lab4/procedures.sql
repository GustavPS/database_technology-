DROP PROCEDURE IF EXISTS addYear;
DROP PROCEDURE IF EXISTS addDay;
DROP PROCEDURE IF EXISTS addDestination;
DROP PROCEDURE IF EXISTS addRoute;

DELIMITER //
CREATE PROCEDURE addYear(IN y INT, IN factor DOUBLE)
BEGIN
	INSERT INTO Year_factor VALUES (y, factor);
END //

CREATE PROCEDURE addDay(IN y INT, IN d VARCHAR(10), IN factor DOUBLE)
BEGIN
	INSERT INTO Day_factor VALUES (d, factor, y);
END //

CREATE PROCEDURE addDestination
(IN airport_code VARCHAR(3), IN airport_name VARCHAR(30), IN country VARCHAR(30))
BEGIN
	INSERT INTO Airport VALUES(airport_code, airport_name, country);
END //

CREATE PROCEDURE addRoute
(IN departure_airport_code VARCHAR(3), IN arrival_airport_code VARCHAR(3),
 IN year_v INT, IN price DOUBLE)
BEGIN
	INSERT INTO Route (departing_from, arriving_to, price, year_v)
	VALUES (departure_airport_code, arrival_airport_code, price, year_v);
END //

CREATE PROCEDURE addFlight
(IN departure_airport_code VARCHAR(3), IN arrival_airport_code VARCHAR(3), IN year_v INT,
 IN day_v VARCHAR(10), IN departure_time TIME)
BEGIN

	INSERT INTO Weekly_schedule (time_of_departure, day_v, route_id)
	VALUES
	(
		departure_time,
		day_v,
		(SELECT id FROM Route WHERE departing_from = departure_airport_code AND
		arriving_to = arrival_airport_code AND Route.year_v = year_v)
	);
	INSERT INTO Flight (week, weekly_schedule_id

END //

DELIMITER ;
