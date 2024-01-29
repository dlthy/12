1. Subqueries IN wHERE
--Tìm những hóa đơn có số tiền lớn hơn số tiền trung bình các hóa đơn
select avg(amount) from payment;
select * from payment
where amount > (select avg(amount) from payment); --> subqueries: truy vấn con trong truy vấn
--Tìm những hóa đơn của KH có tên là Adam

select*from payment 
where customer_id = (select customer_id from customer --truy vấn con chỉ ra 1 kết quả duy nhất
					 where first_name = 'ADAM');

--truy vấn con chỉ ra 1 kết quả duy nhất thì dùng dấu '='
-- truy vấn con chỉ ra nhiều kết quả thì dùng in
/* Tìm những film có thời lượng lớn hơn trung bình các bộ film */
select title, film_id 
from film
where length > (select avg(length) from film);
/* Tìm những bộ film có ở strore 2 ít nhất 3 lần */
select film_id, title from film
where film_id in
(select film_id
from inventory
where store_id = 2
group by film_id
having count(*) >=3);
/*Tìm những KH đến từ California và đã chi tiêu nhiều hơn  */
select customer_id, first_name, last_name, email from customer
where customer_id in 
(select customer_id from payment
group by customer_id
having sum(amount)>100)
2. SUBQUERIES IN FROM
--Tìm những KH có nhiều hơn 30 hóa đơn
select customer_id,
count(payment_id) as so_luong
from payment
group by customer_id
having count(payment_id) > 30;
select customer.first_name, new_table.so_luong
from 
(select customer_id,
count(payment_id) as so_luong
from payment
group by customer_id) as new_table
inner join customer on new_table.customer_id = customer.customer_id
where so_luong > 30
3. SUBQUERIES IN SELECT
Select*,
(select avg(amount) from payment),
(select avg(amount) from payment)-amount
from payment;
Select*,
(select amount from payment limit 1),
(select max (amount) from payment)
from payment;
--Challenge: Chênh lệch giữa số tiền từng hóa đơn so với số tiền thanh toán lớn nhất mà công ty nhận được
select payment_id, amount,
(select max (amount) from payment),
(select max (amount) from payment)- amount
from payment
					 
