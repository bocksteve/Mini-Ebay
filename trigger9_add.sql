PRAGMA foreign_keys = ON;
drop TRIGGER if exists bidSell;
CREATE TRIGGER bidSell
BEFORE INSERT ON Bids
FOR EACH ROW
BEGIN
	SELECT RAISE(ABORT, 'A bidder must not bid on an item he or she is selling.')
	WHERE EXISTS (SELECT * FROM Bids, Item WHERE Bids.itemid = Item.itemid AND Bids.userid = Item.sellerid);
END;
