DELIMITER //

CREATE TRIGGER generateTicket AFTER INSERT ON Booking FOR EACH ROW
BEGIN
	DECLARE finished BOOLEAN DEFAULT FALSE;
	DECLARE ticket INT;
	SET ticket = rand() * 100000;

	WHILE(!finished) DO
	  SET ticket = rand() * 100000;
  	  SET finished = (SELECT 1 - COUNT(*) FROM Ticket WHERE ticket_number = ticket);
	END WHILE;

	UPDATE Ticket SET ticket_number = ticket WHERE reservation_number = NEW.id;
	
END //

DELIMITER ;
