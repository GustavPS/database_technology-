DROP PROCEDURE IF EXISTS addYear;
DROP PROCEDURE IF EXISTS addDay;
DROP PROCEDURE IF EXISTS addDestination;
DROP PROCEDURE IF EXISTS addRoute;
DROP PROCEDURE IF EXISTS addFlight;
DROP PROCEDURE IF EXISTS addReservation;
DROP PROCEDURE IF EXISTS addPassenger;
DROP PROCEDURE IF EXISTS addContact;
DROP PROCEDURE IF EXISTS addPayment;

DELIMITER //
CREATE PROCEDURE addYear(IN y INT, IN factor DOUBLE)
BEGIN
	INSERT IGNORE INTO Year_factor VALUES (y, factor);
END //
CREATE PROCEDURE addDay(IN y INT, IN d VARCHAR(10), IN factor DOUBLE)
BEGIN
	INSERT IGNORE INTO Day_factor VALUES (d, factor, y);
END //

CREATE PROCEDURE addDestination
(IN airport_code VARCHAR(3), IN airport_name VARCHAR(30), IN country VARCHAR(30))
BEGIN
	INSERT IGNORE INTO Airport VALUES(airport_code, airport_name, country);
END //

CREATE PROCEDURE addRoute
(IN departure_airport_code VARCHAR(3), IN arrival_airport_code VARCHAR(3),
 IN year_v INT, IN price DOUBLE)
BEGIN
	INSERT IGNORE INTO Route (departing_from, arriving_to, price, year_v)
	VALUES (departure_airport_code, arrival_airport_code, price, year_v);
END //

CREATE PROCEDURE addFlight
(IN departure_airport_code VARCHAR(3), IN arrival_airport_code VARCHAR(3), IN year_v INT,
 IN day_v VARCHAR(10), IN departure_time TIME)
BEGIN
	DECLARE weeks INT DEFAULT 52;
	DECLARE counter INT DEFAULT 1;
	DECLARE weekly_schedule_id INT;
	
	INSERT IGNORE INTO Weekly_schedule (time_of_departure, day_v, route_id)
	VALUES
	(
		departure_time,
		day_v,
		(SELECT id FROM Route WHERE departing_from = departure_airport_code AND
		arriving_to = arrival_airport_code AND Route.year_v = year_v LIMIT 1)
	);

	SET weekly_schedule_id = LAST_INSERT_ID();

	WHILE counter <= weeks DO
		INSERT IGNORE INTO Flight (week, weekly_schedule_id) VALUES (counter, weekly_schedule_id);
		set counter = counter + 1;
	END WHILE;

END //

CREATE PROCEDURE addReservation
(IN departure_airport_code VARCHAR(3), IN arrival_airport_code VARCHAR(3), IN year_v INT, IN week_v INT,
 IN day_v VARCHAR(10), IN time_v TIME, IN number_of_passengers INT, OUT output_reservation_nr INT)
BEGIN
	DECLARE freeSeats INT DEFAULT -1;
	DECLARE flight INT DEFAULT -1;
	DECLARE weekly_schedule_exist BOOLEAN DEFAULT FALSE;
	DECLARE weekly_schedule_id INT;

	      SET weekly_schedule_id = (SELECT id FROM Weekly_schedule WHERE
	        time_of_departure = time_v AND Weekly_schedule.day_v = day_v AND
		route_id IN (SELECT id FROM Route WHERE departing_from = departure_airport_code AND
                arriving_to = arrival_airport_code AND Route.year_v = year_v));
		
	      SET flight = (SELECT flight_number FROM Flight WHERE week = week_v
	      AND Flight.weekly_schedule_id = weekly_schedule_id);

	      SET weekly_schedule_exist = (SELECT COUNT(*) FROM Weekly_schedule WHERE
	        time_of_departure = time_v AND Weekly_schedule.day_v = day_v AND
		route_id IN (SELECT id FROM Route WHERE departing_from = departure_airport_code AND
                arriving_to = arrival_airport_code AND Route.year_v = year_v));

	      IF weekly_schedule_exist = FALSE THEN
	      	 SELECT 'There exist no flight for the given route, date and time' AS 'Message';
	      ELSE
		SET freeSeats = calculateFreeSeats(flight);

	      	IF freeSeats > number_of_passengers THEN
	      	   INSERT INTO Reservation (flight_number) VALUES (flight);
		   SET output_reservation_nr = LAST_INSERT_ID();
	        ELSE
	    	  SELECT 'There are not enough seats available on the chosen flight' AS 'Message';
	        END IF;
	    END IF;

END //

CREATE PROCEDURE addPassenger
(IN reservation_nr INT, IN passport_number INT, IN name_v VARCHAR(30))
BEGIN
	DECLARE reservation_exist BOOLEAN DEFAULT FALSE;
	DECLARE payed BOOLEAN DEFAULT FALSE;

	SET payed = (SELECT COUNT(*) FROM Booking WHERE id = reservation_nr);
	SET reservation_exist = (SELECT COUNT(*) FROM Reservation WHERE reservation_number = reservation_nr);
	IF reservation_exist = FALSE THEN
	  SELECT 'The given reservation number does not exist' AS 'Message';
	ELSEIF payed = TRUE THEN
	  SELECT 'The booking has already been payed and no futher passengers can be added' AS 'Message';
	ELSE
       	  START TRANSACTION;
	    INSERT IGNORE INTO Passenger (passport_number, first_name) VALUES (passport_number, name_v);
	    INSERT INTO Ticket (reservation_number, passport_number) VALUES (reservation_nr, passport_number);
	  COMMIT;
	END IF;
END //

CREATE PROCEDURE addContact
(IN reservation_nr INT, IN passport_number INT, IN email VARCHAR(30), IN phone BIGINT)
BEGIN
	DECLARE reservation_exist BOOLEAN DEFAULT FALSE;
	DECLARE passenger_exist BOOLEAN DEFAULT FALSE;

	SET passenger_exist = (SELECT COUNT(*) FROM Ticket WHERE Ticket.passport_number = passport_number LIMIT 1);
	
	SET reservation_exist = (SELECT COUNT(*) FROM Reservation WHERE reservation_number = reservation_nr);
	IF reservation_exist = FALSE THEN
	  SELECT 'The given reservation number does not exist' AS 'Message';
	ELSEIF passenger_exist = FALSE THEN
	  SELECT 'The person is not a passenger of the reservation' AS 'Message';
	ELSE
	  START TRANSACTION;
	    INSERT IGNORE INTO Contact (passport_number, email, phone_number) VALUES (passport_number, email, phone);
	    UPDATE Reservation SET contact = passport_number WHERE reservation_number = reservation_nr;
	  COMMIT;
	END IF;
END //

CREATE PROCEDURE addPayment
(IN reservation_nr INT, cardholder_name VARCHAR(30), credit_card_number BIGINT)
BEGIN
	DECLARE freeSeats INT;
	DECLARE reservationSeats INT;
	DECLARE flight INT;
	DECLARE reservation_exist BOOLEAN DEFAULT FALSE;
	DECLARE contact_exist BOOLEAN DEFAULT FALSE;
	SET reservation_exist = (SELECT COUNT(*) FROM Reservation WHERE reservation_number = reservation_nr);

	SET contact_exist = (SELECT COUNT(*) FROM Contact WHERE passport_number IN
	    		    (SELECT contact FROM Reservation WHERE reservation_number = reservation_nr));
	IF reservation_exist = FALSE THEN
	  SELECT 'The given reservation number does not exist' AS 'Message';
	ELSEIF contact_exist = FALSE THEN
	  SELECT 'The reservation has no contact yet' AS 'Message';
	ELSE
	  SET flight = (SELECT flight_number FROM Reservation WHERE reservation_number = reservation_nr);
	  START TRANSACTION;
	    SET freeSeats = calculateFreeSeats(flight);
	  
            SET reservationSeats = (SELECT COUNT(*) FROM Ticket WHERE reservation_number = reservation_nr);
	    IF freeSeats >= reservationSeats THEN
	      INSERT IGNORE INTO Credit_card (card_number, card_holder) VALUES (credit_card_number, cardholder_name);
	      INSERT INTO Booking VALUES (reservation_nr, reservationSeats * calculatePrice(flight),
	      	     	  	  	  credit_card_number);
	    ELSE
	      SELECT 'There are not enough seats available on the flight anymore, deleting reservation' AS 'Message';
	      DELETE FROM Ticket WHERE reservation_number = reservation_nr;
	      DELETE FROM Reservation WHERE reservation_number = reservation_nr;
	    END IF;
	  COMMIT;
	END IF;
END //

DELIMITER ;
