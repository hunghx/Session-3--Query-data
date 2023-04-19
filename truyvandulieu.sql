select * from order_detail where order_id=2;
select * from order_detail where order_id>2;
select * from order_detail where order_id<>2;
select * from order_detail where order_id between 2 and 4;
select * from order_detail where order_id not between 2 and 4;
select * from order_detail where order_id =2 and order_id = 4;
select * from order_detail where order_id =2 or order_id = 4;
select * from order_detail where order_id in (1,3,6,7);
-- join 2 bảng user và order
-- select * from address a join `order` o on a.id=o.id; 
select o.*,u.username `Tên người dùng` from `order` o join `user` u on o.user_id= u.id;
-- alter table `order`
-- add constraint FK_Order foreign key(user_id) references `user`(id);
select * from `user` u right join `order` o on u.id=o.user_id; 

-	-- Lấy dữ liệu từ 3 bảng (lấy tên người mua, mua sản phẩm nào, mua bao nhiêu, mua vào lúc nào )
select u.fullname,od.productName,od.quantity,o.createdDate
from ((`user` u join `order` o on u.id=o.user_id)
join order_detail od on o.id = od.order_id);
-- thống kê số lượng sản phẩm đã bán theo từng sản phẩm > 10
select * from order_detail;
select product_id, sum(quantity), productName, productPrice,productPrice* sum(quantity) as `Thành tiền` 
from order_detail  
group by product_id 
having sum(quantity)>10
order by sum(quantity);
-- lấy ra hoá đơn nhiều tiền nhất
select * from `order` where total = (select max(total) from `order`);
select ou.fullname,ou.total,ou.createdDate from (select u.fullname,o.* from `user` u join `order` o on u.id = o.user_id) ou;
-- lấy ra hoá đơn mua hàng lớn hơn 3 sản phẩm;
select * from `order` where id not in (select order_id from order_detail group by order_id having count(product_id));