PRAGMA foreign_keys = ON;
drop TRIGGER if exists check_bid_time;
CREATE TRIGGER check_bid_time
BEFORE INSERT ON Bids
WHEN NEW.bidtime != CurrentTime.time
BEGIN
  SELECT
  RAISE (ABORT, 'Not correct time');
END;
