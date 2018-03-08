import web

db = web.database(dbn='sqlite', db='eBay.db')

######################BEGIN HELPER METHODS######################

# Enforce foreign key constraints
# WARNING: DO NOT REMOVE THIS!
def enforceForeignKey(): db.query('PRAGMA foreign_keys = ON')

# initiates a transaction on the database
def transaction(): return db.transaction()
# Sample usage (in auctionbase.py):
#
# t = sqlitedb.transaction()
# try:
#   sqlitedb.query('[FIRST QUERY STATEMENT]')
#   sqlitedb.query('[SECOND QUERY STATEMENT]')
# except Exception as e:
#   t.rollback()
#   print str(e)
# else:
#   t.commit()
#
# check out http://webpy.org/cookbook/transactions for examples



# returns the current time from your database
def getTime():
  query_string = 'select time from CurrentTime'
  results = query(query_string)
  return results[0].time  # alternatively: return results[0]['time']



def setTime(new_time):
  t = db.transaction()
  try:
    db.update('CurrentTime', where="time", time = new_time)
  except Exception as e:
    t.rollback()
    print str(e)
  else:
    t.commit()



# returns a single item specified by the Item's ID in the database
def getItemById(item_id):
  q = 'select * from Item where itemID = $itemID'
  result = query(q, { 'itemID': item_id })

  try:
    return result[0]
  except IndexError:
    return None


def getBidsByItemId(itemID):
  q = 'select * from Bid where itemID = $itemID'
  return query(q, {'itemID': itemID})



# returns a single item specified by the Item's ID in the database
def getUserById(user_id):
  q = 'select * from User where userID = $userID'
  result = query(q, { 'userID': user_id })

  try:
    return result[0]
  except IndexError:
    return None



def getItems(vars = {}, minPrice = '', maxPrice = '', status = 'all'):
  # Create basic query that selects all items
  q = 'select * from Item'
    ############# 'where ends > (select time from currenttime)'

  if (vars != {}) or (minPrice != '') or (maxPrice != '') or (status != 'all'):
    q += ' where '
  print(q)

  # If params for the search are indicated, add them to
  # narrow down the query
  if vars != {}:
    q += web.db.sqlwhere(vars, grouping=' AND ')
  print(q)

  # If min- and/or maxPrice are defined, append those restrictions to query
  if (minPrice != '') or (maxPrice != ''):
    if vars != {}:                          q += ' AND '
    if (minPrice != ''):                    q += ' hghstbid >= ' + minPrice #' currently >= ' + minPrice
    if (minPrice != '' and maxPrice != ''): q += ' AND '
    if (maxPrice != ''):                    q += ' hghstbid <= ' + maxPrice #' currently <= ' + maxPrice

  print(q)
  print(status)
  if (status != 'All'):
    if (vars != {}) or (minPrice != '') or (maxPrice != ''):
      q += ' AND '
    if status == 'Open':
      q += 'ends >= (select time from CurrentTime) and started <= (select time from CurrentTime)'
    if status == 'Closed':
      q += 'ends < (select time from CurrentTime)'
    if status == 'Not Started':
      q += 'started > (select time from CurrentTime)'

  print(q)
  # Return result of the query
  return query(q)



def updateItemEndTime(itemID, new_end_time):
  db.update('Item',  where='itemID = ' + itemID,  endtime = new_end_time)


def addBid(itemID, price, userID, current_time):
  db.insert('Bids', itemID = itemID, bidvalue = price, userID = userID, bidtime = current_time)

def getWinnerId(itemID):
  q  = 'select bidderID from Bid '
  q += 'where itemID = $itemID '
  q += 'and amount = ('
  q +=   'select max(amount) from Bid '
  q +=   'where itemID = $itemID'
  q += ')'

  result = query(q, { 'itemID': itemID })

  try:
    return result[0].bidderID
  except IndexError:
    return None

# wrapper method around web.py's db.query method
# check out http://webpy.org/cookbook/query for more info
def query(query_string, vars = {}):
  return list(db.query(query_string, vars))

#adds a new user
def addNewUser(new_userID, new_location, new_country):
  x = 0
  db.insert('User', userID = new_userID, rating = x, location = new_location, country = new_country)

#####################END HELPER METHODS#####################
