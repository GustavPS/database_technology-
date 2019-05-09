DROP TABLE IF EXISTS Passenger
DROP TABLE IF EXISTS Contact
DROP TABLE IF EXISTS Reservation
DROP TABLE IF EXISTS Tickets
DROP TABLE IF EXISTS Booking
DROP TABLE IF EXISTS Credit_card
DROP TABLE IF EXISTS Flight
DROP TABLE IF EXISTS Weekly_schedule
DROP TABLE IF EXISTS Route
DROP TABLE IF EXISTS Airport
DROP TABLE IF EXISTS Profit_factor

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
       CONSTRAINT FK_PassportContact FOREIGN KEY (passport_number)
       REFERENCES Passenger (passport_number)
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
CREATE TABLE Booking (
       id INT,
       total_price DOUBLE,
       card_number BIGINT,
       PRIMARY KEY (id),
       CONSTRAINT FK_CardnumberBooking FOREIGN KEY (card_number)
       REFERENCES Credit_card (card_number)
);
CREATE TABLE Credit_card (
       card_number BIGINT,
       card_holder VARCHAR(30),
       CVV INT,
       PRIMARY KEY (card_number)
);
CREATE TABLE Flight (
       flight_number INT,
       week INT,
       weekly_schedule_id INT,
       PRIMARY KEY (flight_number),
       CONSTRAINT FK_WeeklyscheduleFlight FOREIGN KEY (weekly_schedule_id)
       REFERENCES Weekly_schedule (id)
);
CREATE TABLE Weekly_schedule (
       id INT,
       time_of_departure TIME,
       year_v INT,
       day_v VARCHAR(10),
       route_id INT,
       PRIMARY KEY (id),
       CONSTRAINT FK_YearWeeklyschedule FOREIGN KEY (year_v)
       REFERENCES Profit_factor (year_v)
);
CREATE TABLE Route (
       id INT,
       departing_from INT,
       arriving_to INT,
       PRIMARY KEY (id),
       CONSTRAINT FK_DepartingRoute FOREIGN KEY (departing_from)
       REFERENCES Airport (id),
       CONSTRAINT FK_ArriveRoute FOREIGN KEY (arriving_to)
       REFERENCES Airport (id)
);
CREATE TABLE Airport (
       airport_code VARCHAR(3),
       airport_name VARCHAR(30),
       country VARCHAR(30),
       PRIMARY KEY (airport_code)
);
CREATE TABLE Profit_factor (
       year_v INT,
       Profit_factor DOUBLE,
       monday_factor DOUBLE,
       tuesday_factor DOUBLE,
       wednesday_factor DOUBLE,
       thursday_factor DOUBLE,
       friday_factor DOUBLE,
       saturday_factor DOUBLE,
       sunday_factor DOUBLE,
       PRIMARY KEY (year_v)
);
