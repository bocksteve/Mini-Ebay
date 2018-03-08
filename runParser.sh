#!/bin/sh
rm *.dat
rm eBay.db

python my_parser.py items-*.xml

sort bid.dat | uniq > bid_uniq.dat
sort item.dat | uniq > item_uniq.dat
sort user.dat | uniq > user_uniq.dat
sort category.dat | uniq > category_uniq.dat

sqlite3 eBay.db < create.sql
sqlite3 eBay.db < load.txt
