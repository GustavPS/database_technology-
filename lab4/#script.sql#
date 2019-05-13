SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Passenger;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Credit_card;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Weekly_schedule;
DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Year_factor;
DROP TABLE IF EXISTS Day_factor;
DROP VIEW IF EXISTS allFlights;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Passenger (
       passport_number INT,
       first_name VARCHAR(30),
       last_name VARCHAR(30),
       PRIMARY KEY (passport_number)
);
CREATE TABLE Contact (
       passport_number INT,
       email varchar(30),
       phone_number BIGINT,
       PRIMARY KEY (passport_number),
       CONSTRAINT `FK_PassportContact` FOREIGN KEY (`passport_number`)
       REFERENCES `Passenger` (`passport_number`)
);
CREATE TABLE Year_factor (
       year_v INT,
       factor DOUBLE,
       PRIMARY KEY (year_v)
);

CREATE TABLE Day_factor (
       day_v varchar(10),
       factor DOUBLE,
       year_v INT,
       PRIMARY KEY (day_v),
       CONSTRAINT FK_YearFactor FOREIGN KEY (year_v)
       REFERENCES Year_factor (year_v)
);
CREATE TABLE Airport (
       airport_code VARCHAR(3),
       airport_name VARCHAR(30),
       country VARCHAR(30),
       PRIMARY KEY (airport_code)
);
CREATE TABLE Route (
       id INT AUTO_INCREMENT,
       departing_from VARCHAR(3),
       arriving_to VARCHAR(3),
       price DOUBLE,
       year_v INT,
       PRIMARY KEY (id),
       CONSTRAINT FK_DepartingRoute FOREIGN KEY (departing_from)
       REFERENCES Airport (airport_code),
       CONSTRAINT FK_ArriveRoute FOREIGN KEY (arriving_to)
       REFERENCES Airport (airport_code),
       CONSTRAINT FK_YearRoute FOREIGN KEY (year_v)
       REFERENCES Year_factor (year_v)
);
CREATE TABLE Weekly_schedule (
       id INT AUTO_INCREMENT,
       time_of_departure TIME,
       day_v VARCHAR(10),
       route_id INT,
       PRIMARY KEY (id),
       CONSTRAINT FK_RouteWeeklyschedule FOREIGN KEY (route_id)
       REFERENCES Route (id)
);
CREATE TABLE Flight (
       flight_number INT AUTO_INCREMENT,
       week INT,
       weekly_schedule_id INT,
       PRIMARY KEY (flight_number),
       CONSTRAINT FK_WeeklyscheduleFlight FOREIGN KEY (weekly_schedule_id)
       REFERENCES Weekly_schedule (id)
);
CREATE TABLE Reservation (
       reservation_number INT AUTO_INCREMENT,
       contact INT,
       flight_number INT,
       PRIMARY KEY (reservation_number),
       CONSTRAINT FK_ContactReservation FOREIGN KEY (contact)
       REFERENCES Contact (passport_number),
       CONSTRAINT FK_FlightReservation FOREIGN KEY (flight_number)
       REFERENCES Flight (flight_number)
);
CREATE TABLE Ticket (
       id INT AUTO_INCREMENT,
       reservation_number INT,
       passport_number INT,
       ticket_number INT UNIQUE DEFAULT NULL,
       PRIMARY KEY (id),
       CONSTRAINT FK_PassportTicket FOREIGN KEY (passport_number)
       REFERENCES Passenger(passport_number)
);
CREATE TABLE Credit_card (
       card_number BIGINT,
       card_holder VARCHAR(30),
       CVV INT DEFAULT 999,
       PRIMARY KEY (card_number)
);
CREATE TABLE Booking (
       id INT,
       total_price DOUBLE,
       card_number BIGINT,
       PRIMARY KEY (id),
       CONSTRAINT FK_CardnumberBooking FOREIGN KEY (card_number)
       REFERENCES Credit_card (card_number),
       CONSTRAINT FK_idBooking FOREIGN KEY (id)
       REFERENCES Reservation (reservation_number)
);

source functions.sql;
source procedures.sql;
source triggers.sql;

CREATE VIEW allFlights AS (
  SELECT dep.airport_name AS departure_city_name,
         arr.airport_name AS destination_city_name,
	 Weekly_schedule.time_of_departure AS departure_time,
	 Weekly_schedule.day_v AS departure_day,
	 Flight.week AS departure_week,
	 Route.year_v AS departure_year,
	 calculateFreeSeats(Flight.flight_number) AS nr_of_free_seats,
	 calculatePrice(Flight.flight_number) AS current_price_per_seat
  FROM Flight INNER JOIN Weekly_schedule ON Flight.flight_number = Weekly_schedule.id
  INNER JOIN Route ON Weekly_schedule.route_id = Route.id
  INNER JOIN Airport AS dep ON Route.departing_from = dep.airport_code
  INNER JOIN Airport AS arr ON Route.arriving_to = arr.airport_code);

/* TEST 
source Question3.sql;
source Question6.sql;
*/
source Question7.sql;

/*
CALL addYear(2019, 3);
CALL addDay(2019, 'Monday', 2);
CALL addDestination('CPH', 'Kastrup', 'Denmark');
CALL addDestination('ARN', 'Arlanda', 'Sweden');
CALL addRoute('CPH', 'ARN', 2019, 2000);
CALL addFlight('CPH', 'ARN', 2019, 'Monday', '08:00');
CALL addReservation('CPH', 'ARN', 2019, 50, 'Monday', '08:00', 10, @res);
CALL addPassenger(1, 1, 'Gustav');
CALL addPassenger(1, 2, 'Gffustav');
CALL addContact(1, 1, 'gustavps97@gmail.com', '0702857710');
CALL addPayment(1, 'Gustav', 34);
SELECT @res;

SELECT calculateFreeSeats(1);
SELECT calculatePrice(1);
*/
