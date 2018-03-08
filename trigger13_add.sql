PRAGMA foreign_keys = ON;
drop TRIGGER if exists actual_bids;
CREATE TRIGGER actual_bids
BEFORE INSERT ON Bids
FOR EACH ROW
BEGIN
	SELECT RAISE(ABORT, 'The number of bids must be the actual amount')
	WHERE EXISTS (
		SELECT Item.bidcount, Item.itemid, Tays
		FROM Item,
			(SELECT COUNT(Bids.itemid) AS Tays
			FROM Bids
			GROUP BY Bids.itemid)
		JOIN Bids ON
		Item.bidcount == Tays
		WHERE Item.bidcount != Tays
		GROUP BY Item.itemid
		);
END;
