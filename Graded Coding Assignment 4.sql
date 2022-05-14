Create Database `TravelOnTheGo`;
use `TravelOnTheGo`;

CREATE TABLE `travelonthego`.`passenger` (
  `Passenger_name` VARCHAR(50),
  `Category` VARCHAR(10),
  `Gender` VARCHAR(10),
  `Boarding_City` VARCHAR(50),
  `Destination_City` VARCHAR(50),
  `Distance` INT,
  `Bus_Type` VARCHAR(20));
     
  -- data insert
  
  insert into `passenger` values("Sejal","AC","F","Bengaluru","Chennai","350","Sleeper");
  insert into `passenger` values("Anmol","Non-AC","M","Mumbai","Hyderabad","700","Sitting");
  insert into `passenger` values("Pallavi","AC","F","Panaji","Bengaluru","600","Sleeper");
  insert into `passenger` values("Khusboo","AC","F","Chennai","Mumbai","1500","Sleeper");
  insert into `passenger` values("Udit","Non-AC","M","Trivandrum","Panaji","1000","Sleeper");
  insert into `passenger` values("Ankur","AC","M","Nagpur","Hyderabad","500","Sitting");
  insert into `passenger` values("Hemant","Non-AC","M","Panaji","Mumbai","700","Sleeper");
  insert into `passenger` values("Manish","Non-AC","M","Hyderabad","Bengaluru","500","Sitting");
  insert into `passenger` values("Piyush","AC","M","Pune","Nagpur","700","Sitting");
   
  
CREATE TABLE `travelonthego`.`price` (
  `Bus_Type` VARCHAR(20),
  `Distance` INT,
  `price` INT);
  
  -- data insert
  
  insert into `price` values ("Sleeper","350","770");
  insert into `price` values ("Sleeper","500","1100");
  insert into `price` values ("Sleeper","600","1320");
  insert into `price` values ("Sleeper","700","1540");
  insert into `price` values ("Sleeper","1000","2200");
  insert into `price` values ("Sleeper","1200","2640");
  insert into `price` values ("Sleeper","1500","2700");
  insert into `price` values ("Sitting","500","620");
  insert into `price` values ("Sitting","600","744");
  insert into `price` values ("Sitting","700","868");
  insert into `price` values ("Sitting","1000","1240");
  insert into `price` values ("Sitting","1200","1488");
  insert into `price` values ("Sitting","1500","1860");
  
  
 --  3) How many females and how many male passengers travelled for a minimum distance of 600 KMs?
select passenger.gender, count(passenger.gender) as count
from passenger
where passenger.distance>=600
group by passenger.gender;

-- 4) Find the minimum ticket price for Sleeper Bus.
select price.bus_type, min(price.price) as 'min.price' from price
where Bus_type='Sleeper'
group by price.bus_type;

-- 5) Select passenger names whose names start with character 'S'
select passenger_name as 'names with S' from passenger 
where  ( passenger_name like 'S%');

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output

select passenger.passenger_name,passenger.boarding_city, passenger.destination_city,passenger.bus_type,price.price
from passenger
inner join price
on passenger.distance = price.distance
AND passenger.bus_type = price.bus_type;
 
-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
-- for a distance of 1000 KM s

select passenger.passenger_name, price.price from passenger
inner join price
on passenger.distance = price.distance
where passenger.distance = "1000" AND price.distance = "1000"
and passenger.bus_type = "sitting" AND price.bus_type = "sitting";


-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
-- panaji?

select price.Bus_Type,price.Distance,price.Price
from price 
where price.distance in (
		select distance from passenger 
where (Boarding_City = 'Bengaluru' and Destination_City = 'Panaji') or (Boarding_City = 'Panaji' and Destination_City = 'Bengaluru') and Passenger_name = 'Pallavi')
having price.Bus_Type='Sleeper' or price.Bus_Type='Sitting' ; 


-- 9) List the distances from the "Passenger" table which are unique (non-repeated
-- distances) in descending order.

select distinct passenger.distance from passenger
order by passenger.distance desc;


-- 10) Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables

 select passenger.passenger_name,
 passenger.distance * 100 / (select sum(passenger.distance) from passenger) as "% of distance"
 from passenger;

/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/


select price.distance,price.price,
case
when price > 1000 then "Expensive"
when price > 500 then "Average"
else "Cheap"
end as verdict
from price;

/***/

 
