Create Database if not exists `TravelOnTheGo` ;
use `TravelOnTheGo`;

create table PASSENGER
(
 Passenger_name varchar(50),
 Category varchar(10),
 Gender varchar(10),
 Boarding_City varchar(50),
 Destination_City varchar(50),
 Distance int,
 Bus_Type varchar(30)
);

create table PRICE
(
 Bus_Type varchar(30),
 Distance int,
 Price int
 );
 
 insert into `PASSENGER` values("Sejal","AC", "F","Bengaluru", "Chennai", 350, "Sleeper");
 insert into `PASSENGER` values("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting");
 insert into `PASSENGER` values("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper");
 insert into `PASSENGER` values("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper");
 insert into `PASSENGER` values("Udit", "Non-AC", "M", "Trivandrum", "panaji", 1000, "Sleeper");
 insert into `PASSENGER` values("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting");
 insert into `PASSENGER` values("Hemant", "Non-AC", "M", "panaji", "Mumbai", 700, "Sleeper");
 insert into `PASSENGER` values("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting");
 insert into `PASSENGER` values("Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting");
 

insert into `PRICE` values("Sleeper", 350, 770);
insert into `PRICE` values("Sleeper", 500, 1100);
insert into `PRICE` values("Sleeper", 600, 1320);
insert into `PRICE` values("Sleeper", 700, 1540);
insert into `PRICE` values("Sleeper", 1000, 2200);
insert into `PRICE` values("Sleeper", 1200 ,2640);
insert into `PRICE` values("Sleeper", 1500, 2700);
insert into `PRICE` values("Sitting" ,500, 620);
insert into `PRICE` values("Sitting" ,600, 744);
insert into `PRICE` values("Sitting" ,700 ,868);
insert into `PRICE` values("Sitting" ,1000 ,1240);
insert into `PRICE` values("Sitting" ,1200 ,1488);
insert into `PRICE` values("Sitting" ,1500 ,1860);

-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?
select Gender,Count(Gender) from `PASSENGER`  where Distance>=600 group by Gender; 

-- 4) Find the minimum ticket price for Sleeper Bus. 
select min(price) from `PRICE` where Bus_type="Sleeper";

-- 5) Select passenger names whose names start with character 'S'
select Passenger_name from `PASSENGER` where Passenger_name like 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output
select `PASSENGER`.Passenger_name, `PASSENGER`.Boarding_city, `PASSENGER`.Destination_city, `PASSENGER`.Bus_type, `PRICE`.price 
from `PASSENGER` inner join `PRICE` 
on `PASSENGER`.Distance=`PRICE`.Distance;

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
-- for a distance of 1000 KM s 
select `PASSENGER`.Passenger_name, `PRICE`.Price
from `PASSENGER` inner join `PRICE` 
on `PASSENGER`.Distance=`PRICE`.Distance
where `PASSENGER`.Bus_type='Sitting' and `PASSENGER`.Distance=1000;


-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
-- Panaji
select bus_type, price from price where distance in (select Distance from passenger where Passenger_name="Pallavi");

-- 9)List the distances from the "Passenger" table which are unique (non-repeated
-- distances) in descending order
select DISTINCT Distance from passenger order by Distance Desc;

-- 10) Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables

select pn.passenger_name, sum(distinct(pn.distance))/sum(p.distance)*100 from 
passenger as pn, passenger p
group by pn.Passenger_name;

-- 11)Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise

select distance, price,
	case when price > 1000 Then 'Expensive'
		 when price between 500 and 100 then 'Average'
         else 'Cheap' 
	End AS Class
    from price