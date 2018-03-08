SELECT Item.bidcount, Item.itemid, Tays
FROM Item,
	(SELECT COUNT(Bids.itemid) AS Tays FROM Bids GROUP BY Bids.itemid)
JOIN Bids ON
Item.bidcount == Tays
WHERE Item.bidcount == Tays
GROUP BY Item.itemid
;
