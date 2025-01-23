--d.i
select p.name as "product name",p.price, n.calories,n.fats,n.sugar,n.name as "nutrition name", c.name as "category name" from products p
join nutritions n on p.product_id=n.product_id
join category c on p.category_id=c.category_id;
--d.ii
select o.*,p.*,po.amount from orders o
join products_orders po on po.order_id = o.order_id
join products p on po.product_id = p.product_id;
--d.iii
insert into products_orders (order_id,product_id,amount) values
(1,3,1);
(2,4,1);
(3,3,1);
(4,3,1);
(5,2,1);
(6,1,2);
(6,2,2);
(6,4,2);

--d.iv
update orders  set total_price=t.tp 
FROM
(
select po.order_id as o_id,sum(po.amount)*p.price as tp from products_orders po
join products p on po.product_id=p.product_id
group by order_id
)t
where orders.order_id=t.o_id
--d.v get the most expestive order- easy way:
select * from orders o
where o.total_price=(
select max(o.total_price) from orders o 
)
limit 1

-- d.v hard way:
select o.* from orders o join 
(select order_id,max(total_price) from (
select po.order_id as order_id,sum(po.amount)*p.price as total_price from products_orders po
join products p on po.product_id=p.product_id
group by order_id)) max_o 
on max_o.order_id=o.order_id
limit 1

-- the cheapest order , easy way:
select * from orders o
where o.total_price=(
select min(o.total_price) from orders o 
)
limit 1
-- the cheapest order, hard way

select o.* from orders o join 
(select order_id,min(total_price) from (
select po.order_id as order_id,sum(po.amount)*p.price as total_price from products_orders po
join products p on po.product_id=p.product_id
group by order_id)) min_o 
on min_o.order_id=o.order_id
limit 1

-- the order that the total_price is the closest to the avg 
SELECT * FROM orders o
ORDER BY ABS(o.total_price - (select avg(o.total_price) from orders o))
LIMIT 1


--d.vi customer_name with the most orders
select o.customer_name,count(o.customer_name ) as orders_count from orders o 
group by o.customer_name 
HAVING count(o.customer_name )=
(select max(order_count) as max_order FROM (
select count(orders.customer_name) as order_count from orders group by orders.customer_name))
LIMIT 1

-- d.vii most saller product from all orders together
select p.*, max_value from products p JOIN
(select max(total_amount) as max_value,p_id from
(select p.product_id as p_id,sum(po.amount) as total_amount from products p join products_orders po on po.product_id=p.product_id
GROUP by po.product_id)) max_p
on max_p.p_id=p.product_id
limit 1

-- vii. the first product that was the least seller  from all the exist orders
select p.*, min_value from products p JOIN
(select min(total_amount) as min_value,p_id from
(select p.product_id as p_id,sum(po.amount) as total_amount from products p join products_orders po on po.product_id=p.product_id
GROUP by po.product_id)) total_p
on total_p.p_id=p.product_id

-- the first product that was the least seller from all the exist products
select p.* from products p
left JOIN products_orders po
on p.product_id=po.product_id
where po.product_id is null;

--avgerage product seller
SELECT p.* FROM products p join (
select avg(total_amount) as avg_value,p_id from
(select p.product_id as p_id,sum(po.amount) as total_amount from products p join products_orders po on po.product_id=p.product_id
GROUP by po.product_id)) avg_product 
on p.product_id=avg_product.p_id

-- viii category with max product seller 
select c.* from category c join (
select max(total_amount) as max_value,max_category from
(select p.category_id as max_category,p.product_id as p_id,sum(po.amount) as total_amount from products p join products_orders po on po.product_id=p.product_id
GROUP by po.product_id)) max_seller_amount
on max_seller_amount.max_category=c.category_id

-- viii category with min product seller 
select c.* from category c JOIN
(select min(total_amount) as min_value,c_id from
(select p.category_id as c_id,sum(po.amount) as total_amount from products p join products_orders po on po.product_id=p.product_id
GROUP by po.product_id)) total_p
on total_p.c_id=c.category_id