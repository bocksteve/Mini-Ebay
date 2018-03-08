drop TRIGGER if exists update_highest_price;
CREATE TRIGGER update_highest_price
AFTER INSERT ON Bids
BEGIN
 update Item
 set hghstbid = new.bidvalue
 where Item.itemid = new.itemid;
END;
