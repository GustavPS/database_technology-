DROP FUNCTION IF EXISTS calculateFreeSeats;
DROP FUNCTION IF EXISTS calculatePrice;

DELIMITER //
CREATE FUNCTION calculateFreeSeats(flight_number INT) RETURNS INT
BEGIN
	DECLARE seats INT;
	SET seats = (SELECT 40 - COUNT(*) FROM Booking WHERE id IN
       	(SELECT reservation_number FROM Reservation WHERE Reservation.flight_number = flight_number));
	RETURN seats;
END  //

CREATE FUNCTION calculatePrice(flight_number INT) RETURNS DOUBLE
BEGIN
	DECLARE totalPrice DOUBLE;
	DECLARE routePrice DOUBLE;
	DECLARE weekdayFactor DOUBLE;
	DECLARE profitFactor DOUBLE;
	DECLARE passengers INT;

	SET routePrice = (SELECT price FROM Route WHERE id IN
	    (SELECT route_id FROM Weekly_schedule WHERE id IN
	    (SELECT weekly_schedule_id FROM Flight WHERE Flight.flight_number = flight_number)));
	SET weekdayFactor = (SELECT factor FROM Day_factor WHERE day_v IN
	    (SELECT day_v FROM Weekly_schedule WHERE id IN
	    (SELECT weekly_schedule_id FROM Flight WHERE Flight.flight_number = flight_number)) AND
	    (SELECT year_v FROM Route WHERE id IN
	    (SELECT route_id FROM Weekly_schedule WHERE id IN
	    (SELECT weekly_schedule_id FROM Flight WHERE Flight.flight_number = flight_number))));
	SET profitFactor = (SELECT factor FROM Year_factor WHERE year_v IN
	    (SELECT year_v FROM Route WHERE id IN
	    (SELECT route_id FROM Weekly_schedule WHERE id IN
	    (SELECT weekly_schedule_id FROM Flight WHERE Flight.flight_number = flight_number))));
	SET passengers = 40 - calculateFreeSeats(flight_number);

	RETURN ROUND((routePrice * weekdayFactor * (passengers+1)/40 * profitFactor), 2);
END //

DELIMITER ;
