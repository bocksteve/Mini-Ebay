PRAGMA foreign_keys = ON;
drop TRIGGER if exists check_duplicate_bid;
CREATE TRIGGER check_duplicate_bid
BEFORE INSERT ON Bids
WHEN NEW.itemid = Bids.itemid AND NEW.bidvalue = Bids.bidvalue
BEGIN
  SELECT
  RAISE (ABORT, 'Already bid for that amount');
END;