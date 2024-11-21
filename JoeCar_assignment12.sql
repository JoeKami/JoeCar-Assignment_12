-- create database joes_pizzapallooza;

CREATE TABLE IF NOT EXISTS customers (
cust_id INT auto_increment primary key,
name varchar(100) NOT NULL,
phone_num varchar(15) NOT NULL 
);

CREATE TABLE IF NOT EXISTS pizzas (
menu_id INT auto_increment primary key,
pizza_type varchar(50) NOT NULL, 
price DECIMAL(5, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
order_id INT auto_increment primary key,
cust_id INT, 
order_date_time datetime NOT NULL, 
foreign key (cust_id) references customers(cust_id)
);

CREATE TABLE IF NOT EXISTS order_details (
order_details_id INT auto_increment primary key,
order_id INT,
menu_id INT,
quantity INT NOT NULL,
foreign key (order_id) references orders(order_id),
foreign key (menu_id) references pizzas(menu_id)
);

insert into customers (name, phone_num)
values ('Trevor Page', '226-555-4982'),
('John Doe', '555-555-9498');

insert into pizzas (pizza_type, price)
values ('Pepperoni & Cheese', 7.99), 
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian', 12.99);

insert into orders (cust_id, order_date_time)
values (1, '2023-09-10 09:47:00'),
(2, '2023-09-10 13:20:00'),
(1, '2023-09-10 09:47:00'),
(2, '2023-10-10 10:37:00');

insert into order_details (order_id, menu_id, quantity)
values (1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(2, 3, 2),
(3, 3, 1), 
(3, 4, 1),
(4, 2, 3),
(4, 4, 1);

-- CREATE TABLE q4_totals as
select c.name, sum(p.price * od.quantity) as total_spent
from customers c
join orders o on c.cust_id = o.cust_id
join order_details od on o.order_id = od.order_id
join pizzas p on od.menu_id = p.menu_id
group by c.name;

-- CREATE TABLE q5_by_dates as 
select c.name, date(o.order_date_time) as order_date, sum(p.price * od.quantity) as total_spent
from customers c
join orders o on c.cust_id = o.cust_id
join order_details od on o.order_id = od.order_id
join pizzas p on od.menu_id = p.menu_id
group by c.name, order_date
order by order_date;