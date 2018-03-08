PRAGMA foreign_keys = ON;
drop TRIGGER if exists check_lower_bid;
CREATE TRIGGER check_lower_bid
BEFORE INSERT ON Bids
WHEN NEW.itemid = Bids.itemid AND NEW.bidvalue < Bids.bidvalue
BEGIN
  SELECT
  RAISE (ABORT, 'Need to bid higher then current bid');
END;
