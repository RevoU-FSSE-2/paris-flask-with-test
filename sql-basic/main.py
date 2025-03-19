sql = """
UPDATE customers SET phone='{phone}' where customer_id={user_id};
"""

def user_router(_id, phone_number):
    
    query = sql.format(user_id=_id, phone=phone_number)
    con_db = None
    print(query)
    # con_db.execute(query)
    # con_db.commit()
    
user_router("1; SELECT name FROM customers", "1234567890")