CREATE TABLE if NOT EXISTS category (
category_id INTEGER PRIMARY KEY, 
name TEXT);

CREATE TABLE if NOT EXISTS orders (
order_id INTEGER PRIMARY KEY, 
date_time TEXT,
address TEXT,
customer_name TEXT,
customer_ph TEXT,
total_price INTEGER);

CREATE TABLE if NOT EXISTS products (
product_id INTEGER PRIMARY KEY, 
name TEXT,
price INTEGER,
category_id INTEGER,
FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE if NOT EXISTS nutritions (
nutrition_id INTEGER PRIMARY KEY, 
product_id INTEGER,
name TEXT,
calories INTEGER,
fats INTEGER,
sugar INTEGER,
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE products_orders (
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  amount INTEGER NOT NULL,
                PRIMARY KEY(order_id, product_id),
     FOREIGN KEY (order_id) REFERENCES orders(order_id),
     FOREIGN KEY (product_id) REFERENCES products(product_id)
);
