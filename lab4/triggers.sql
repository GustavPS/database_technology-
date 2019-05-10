DELIMITER //

CREATE TRIGGER generateTicket AFTER INSERT ON Booking FOR EACH ROW
BEGIN
	UPDATE Ticket SET ticket_number = rand() * 100000 WHERE reservation_number = NEW.id;
END //

DELIMITER ;
