PRAGMA foreign_keys = ON;
drop TRIGGER if exists stop_early_late_bids;
CREATE TRIGGER stop_early_late_bids
BEFORE INSERT ON Bids
BEGIN 
  SELECT RAISE (ABORT, 'Too early or late bid')
  WHERE EXISTS (SELECT * FROM Item WHERE NEW.itemid == Item.itemid AND (NEW.bidtime > Item.endtime OR NEW.bidtime < Item.strttime));
END;