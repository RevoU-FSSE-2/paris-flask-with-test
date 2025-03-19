import duckdb

users = duckdb.read_json("db.json")
data = duckdb.sql("SELECT * FROM users")
duckdb.sql(
    """
    INSERT INTO users VALUES (6, 'maria Mercedes', 'Mercedes@gmail.com', 23, 'MALANG') 
    """
)
print(data)
