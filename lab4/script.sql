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
       reservation_number INT,
       contact INT,
       flight_number INT,
       PRIMARY KEY (reservation_number),
       CONSTRAINT FK_ContactReservation FOREIGN KEY (contact)
       REFERENCES Contact (passport_number),
       CONSTRAINT FK_FlightReservation FOREIGN KEY (flight_number)
       REFERENCES Flight (flight_number)
);
CREATE TABLE Ticket (
       reservation_number INT,
       passport_number INT,
       ticket_number INT,
       PRIMARY KEY (ticket_number),
       CONSTRAINT FK_PassportTicket FOREIGN KEY (passport_number)
       REFERENCES Passenger(passport_number)
);
CREATE TABLE Credit_card (
       card_number BIGINT,
       card_holder VARCHAR(30),
       CVV INT,
       PRIMARY KEY (card_number)
);
CREATE TABLE Booking (
       id INT,
       total_price DOUBLE,
       card_number BIGINT,
       PRIMARY KEY (id),
       CONSTRAINT FK_CardnumberBooking FOREIGN KEY (card_number)
       REFERENCES Credit_card (card_number)
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

source procedures.sql;
CALL addYear(2019, 3);
CALL addDay(2019, 'Monday', 2);
CALL addDestination('CPH', 'Kastrup', 'Denmark');
CALL addDestination('ARN', 'Arlanda', 'Sweden');
CALL addRoute('CPH', 'ARN', 2019, 2000);
