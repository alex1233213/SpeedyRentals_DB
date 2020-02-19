--Databases assignment - Part 2
--Student name: Alexandru Bulgari
--Student number: C18342126
--Programme code: DT228



--Drop all tables and constraints
DROP TABLE "ONLINESALESREPRESENTATIVE" CASCADE CONSTRAINTS;
DROP TABLE "SPEEDYRENTALS" CASCADE CONSTRAINTS;
DROP TABLE "SALESREPRESENTATIVE" CASCADE CONSTRAINTS;
DROP TABLE "CUSTOMER" CASCADE CONSTRAINTS;
DROP TABLE "MILEAGE" CASCADE CONSTRAINTS;
DROP TABLE "CONTRACT" CASCADE CONSTRAINTS;
DROP TABLE "CUSTOMERCONTRACT" CASCADE CONSTRAINTS;
DROP TABLE "CAR" CASCADE CONSTRAINTS;
DROP TABLE "CARTYPE" CASCADE CONSTRAINTS;
DROP TABLE "BILL" CASCADE CONSTRAINTS;
DROP TABLE "BRANCHRENTAL" CASCADE CONSTRAINTS;
DROP TABLE "ONLINERENTALCONTRACT" CASCADE CONSTRAINTS;
DROP TABLE "CUSTOMERBILL" CASCADE CONSTRAINTS;
DROP TABLE "BRANCHCONTRACT" CASCADE CONSTRAINTS;


--Create all tables statements

CREATE TABLE bill (
    billid          NUMBER(6) NOT NULL,
    rentalperiod    INTEGER,
    dailycost       NUMBER(9, 2),
    rentalmileage   INTEGER,
    totalcost       NUMBER(9, 2)
);

ALTER TABLE bill ADD CONSTRAINT bill_pk PRIMARY KEY ( billid );

CREATE TABLE branchcontract (
    contractid               NUMBER(6) NOT NULL,
    branchid                 NUMBER(6) NOT NULL
);


ALTER TABLE branchcontract ADD CONSTRAINT branchcontract_pk PRIMARY KEY ( contractid );

CREATE TABLE branchrental (
    branchid                      NUMBER(6) NOT NULL,
    staffid                       NUMBER(6) NOT NULL
);

ALTER TABLE branchrental ADD CONSTRAINT branchrental_pk PRIMARY KEY ( branchid,
                                                                      staffid );

CREATE TABLE car (
    modelid         NUMBER(6) NOT NULL,
    regno           VARCHAR2(30) NOT NULL,
    dailycost       NUMBER(9, 2)
);

CREATE UNIQUE INDEX car__idx ON
    car (
        regno
    ASC );

ALTER TABLE car ADD CONSTRAINT car_pk PRIMARY KEY ( modelid );

CREATE TABLE cartype (
    regno          VARCHAR2(30) NOT NULL,
    manufacturer   VARCHAR2(30),
    carmodel       VARCHAR2(30),
    category       VARCHAR2(30),
    fueltype       VARCHAR2(30)
);

ALTER TABLE cartype ADD CONSTRAINT cartype_pk PRIMARY KEY ( regno );

CREATE TABLE contract (
    contractid       NUMBER(6) NOT NULL,
    modelid          NUMBER(6) NOT NULL,
    rentalperiod     INTEGER,
    fuelamount       NUMBER(9, 2),
    pickupdate       DATE,
    returndate       DATE,
    pickuplocation   VARCHAR2(50)
);

CREATE UNIQUE INDEX contract__idx ON
    contract (
        modelid
    ASC );

ALTER TABLE contract ADD CONSTRAINT contract_pk PRIMARY KEY ( contractid );

CREATE TABLE customer (
    custid    NUMBER(6) NOT NULL,
    name      VARCHAR2(30) NOT NULL,
    address   VARCHAR2(50) NOT NULL,
    email     VARCHAR2(50) NOT NULL,
    age       NUMBER(3) NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( custid );

CREATE TABLE customerbill (
    custid            NUMBER(6) NOT NULL,
    billid            NUMBER(6) NOT NULL
);

CREATE UNIQUE INDEX customerbill__idx ON
    customerbill (
        billid
    ASC );

ALTER TABLE customerbill ADD CONSTRAINT customerbill_pk PRIMARY KEY ( custid,
                                                                      billid );

CREATE TABLE customercontract (
    contractid            NUMBER(6) NOT NULL,
    custid                NUMBER(6) NOT NULL
);

CREATE UNIQUE INDEX customercontract__idx ON
    customercontract (
        contractid
    ASC );

ALTER TABLE customercontract ADD CONSTRAINT customercontract_pk PRIMARY KEY ( contractid );

CREATE TABLE mileage (
    regno           VARCHAR2(30) NOT NULL,
    mileagebefore   INTEGER,
    mileageafter    INTEGER
);

CREATE UNIQUE INDEX mileage__idx ON
    mileage (
        regno
    ASC );

ALTER TABLE mileage ADD CONSTRAINT mileage_pk PRIMARY KEY ( regno );

CREATE TABLE onlinerentalcontract (
    contractid             NUMBER(6) NOT NULL,
    staffid                NUMBER(6) NOT NULL,
    transactionverified    CHAR(1) NOT NULL,
    emailsent              CHAR(1) NOT NULL
);

CREATE UNIQUE INDEX onlinerentalcontract__idx ON
    onlinerentalcontract (
        contractid
    ASC );

ALTER TABLE onlinerentalcontract ADD CONSTRAINT onlinerentalcontract_pk PRIMARY KEY ( contractid,
     staffid );

CREATE TABLE onlinesalesrepresentative (
    staffid                       NUMBER(6) NOT NULL
);

CREATE UNIQUE INDEX onlinesalesrepresentative__idx ON
    onlinesalesrepresentative (
        staffID
    ASC );

ALTER TABLE onlinesalesrepresentative ADD CONSTRAINT onlinesalesrepresentative_pk PRIMARY KEY ( staffid );

CREATE TABLE salesrepresentative (
    staffid          NUMBER(6) NOT NULL,
    branchid         NUMBER(6) NOT NULL,
    name             VARCHAR2(30),
    address          VARCHAR2(50),
    phonenum         VARCHAR2(50),
    email            VARCHAR2(50),
    dateofbirth      DATE,
    employmentdate   DATE
);

ALTER TABLE salesrepresentative ADD CONSTRAINT salesrepresentative_pk PRIMARY KEY ( staffid );

CREATE TABLE speedyrentals (
    branchid   NUMBER(6) NOT NULL,
    address    VARCHAR2(50) NOT NULL,
    phonenum   VARCHAR2(50) NOT NULL
);

ALTER TABLE speedyrentals ADD CONSTRAINT speedyrentals_pk PRIMARY KEY ( branchid );


--Create foreign keys for tables
ALTER TABLE branchcontract
    ADD CONSTRAINT branchcon_speedyrentals_fk FOREIGN KEY ( branchid )
        REFERENCES speedyrentals ( branchid );

ALTER TABLE branchcontract
    ADD CONSTRAINT branchcontract_contract_fk FOREIGN KEY ( contractid )
        REFERENCES contract ( contractid );

ALTER TABLE branchrental
    ADD CONSTRAINT branchrental_salesrep_fk FOREIGN KEY ( staffid )
        REFERENCES salesrepresentative ( staffid );

ALTER TABLE branchrental
    ADD CONSTRAINT branchrental_speedyrentals_fk FOREIGN KEY ( branchid )
        REFERENCES speedyrentals ( branchid );

ALTER TABLE car
    ADD CONSTRAINT car_cartype_fk FOREIGN KEY ( regno )
        REFERENCES cartype ( regno );

ALTER TABLE contract
    ADD CONSTRAINT contract_car_fk FOREIGN KEY ( modelid )
        REFERENCES car ( modelid );

ALTER TABLE customerbill
    ADD CONSTRAINT customerbill_bill_fk FOREIGN KEY ( billid )
        REFERENCES bill ( billid );

ALTER TABLE customerbill
    ADD CONSTRAINT customerbill_customer_fk FOREIGN KEY ( custid )
        REFERENCES customer ( custid );

ALTER TABLE customercontract
    ADD CONSTRAINT customercontract_contract_fk FOREIGN KEY ( contractid )
        REFERENCES contract ( contractid );

ALTER TABLE customercontract
    ADD CONSTRAINT customercontract_customer_fk FOREIGN KEY ( custid )
        REFERENCES customer ( custid );

ALTER TABLE mileage
    ADD CONSTRAINT mileage_cartype_fk FOREIGN KEY ( regno )
        REFERENCES cartype ( regno );

ALTER TABLE onlinesalesrepresentative
    ADD CONSTRAINT online_salesrep_fk FOREIGN KEY ( staffid )
        REFERENCES salesrepresentative ( staffid );

ALTER TABLE onlinerentalcontract
    ADD CONSTRAINT onlinerental_contract_fk FOREIGN KEY ( contractid )
        REFERENCES contract ( contractid );

ALTER TABLE onlinerentalcontract
    ADD CONSTRAINT onlinerental_onlinesalesrep_fk FOREIGN KEY ( staffid )
        REFERENCES onlinesalesrepresentative ( staffid );
        
        

--insert statements


--insert data into speedyrentals
insert into speedyrentals(branchid, address, phoneNum ) values (1,'21 Oconell Street, Dublin','01222');
insert into speedyrentals(branchid, address, phoneNum ) values (2,'43 Long Road, Cork','01444');
insert into speedyrentals(branchid, address, phoneNum ) values (3,'22 Long Mile Road, Dulin','01333');
insert into speedyrentals(branchid, address, phoneNum ) values (4,'6 Temple Bar, Dublin','01555');
insert into speedyrentals(branchid, address, phoneNum ) values (5,'89 SpringDale Road, Dublin','01777');



--insert data into sales representative
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth, employmentDate) values (1, 1, 'Alex Jones', '33 Big road' ,'08711111', 'alex@speedyrentals.com' , DATE '1988-02-12' , DATE '2019-02-12');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (2, 1, 'Jon Jones', '11 Open road' ,'08788888', 'jon@speedyrentals.com', DATE '1999-02-01' , DATE '2018-02-11');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (3, 1, 'Donald Cerrone', '22 Texas Road' ,'0899999', 'donald@speedyrentals.com', DATE '1998-03-01' , DATE '2017-03-02');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (4, 1, 'Conor Jones', '21 Dublin Road' ,'08511111', 'conor@speedyrentals.com', DATE '1997-06-22' , DATE '2016-02-01');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (5, 1, 'Khabib Jones', '1 SpringDale Road' ,'08577777', 'khabib@speedyrentals.com', DATE '2006-03-11' , DATE '2014-03-03');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (6, 3, 'Joe Jones', '1 Meath Road' ,'08577887', 'joejo@speedyrentals.com', DATE '2001-03-10' , DATE '2014-03-03');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (7, 3, 'Georgia Reynolds', '1 New york Road' ,'08522727', 'georgiarey@speedyrentals.com', DATE '2000-03-11' , DATE '2017-03-03');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (8, 3, 'Martina Wrosek', '32 New York Road' ,'08539483', 'martinawr@speedyrentals.com', DATE '1995-02-21' , DATE '2018-04-04');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (9, 4, 'Joana Jones', '33 SpringDale Road' ,'08578097', 'joanajones@speedyrentals.com', DATE '1992-09-12' , DATE '2019-01-01');
insert into salesrepresentative (staffid, branchid, name , address, phonenum, email ,dateofbirth , employmentDate) values (10, 5, 'Valentina Alford', '43 Abbey street' ,'085721234', 'valentinaalf@speedyrentals.com', DATE '1997-06-11' , DATE '2018-05-02');






--insert data into branchrental
insert into branchrental(branchid, staffid) values (1, 1);
insert into branchrental(branchid, staffid) values (1, 2);
insert into branchrental(branchid, staffid) values (1, 3);
insert into branchrental(branchid, staffid) values (1, 4);
insert into branchrental(branchid, staffid) values (1, 5);







--insert data into cartype
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('kx99', 'toyota', 'prius', 'salon', 'petrol');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('iop1123', 'bmw', 'x5', 'salon', 'petrol');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('nfg987', 'mercedes', 'i10', 'hatchback', 'diesel');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('hyt865', 'honda', 'civic', 'salon', 'diesel');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('mod98', 'tesla', 'cybertruck', 'salon', 'petrol');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('fase23', 'bmw', '520', 'salon', 'petrol');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('gsrd21', 'toyota', 'versus', 'hatchback', 'diesel');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('ng12', 'minicooper', 'x10', 'hatchback', 'petrol');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('yjgf23', 'nissan', 's12', 'salon', 'petrol');
insert into cartype(regno , manufacturer, carmodel, category, fueltype) values ('mvx33', 'opel', 'astra', 'salon', 'petrol');





----insert data into car
insert into car(modelid, regno , dailycost) values (3, 'kx99', 95.99);
insert into car(modelid, regno , dailycost) values (4, 'iop1123', 120.99);
insert into car(modelid, regno , dailycost) values (5, 'nfg987', 99.99);
insert into car(modelid, regno , dailycost) values (6, 'hyt865', 80.99);
insert into car(modelid, regno , dailycost) values (7, 'mod98', 110.99);
insert into car(modelid, regno , dailycost) values (8, 'fase23', 100.99);
insert into car(modelid, regno , dailycost) values (9, 'gsrd21', 103.99);
insert into car(modelid, regno , dailycost) values (10, 'ng12', 1105.99);
insert into car(modelid, regno , dailycost) values (11, 'yjgf23', 80.99);
insert into car(modelid, regno , dailycost) values (12, 'mvx33', 85.99);




--insert data into mileage
insert into mileage(regno, mileagebefore, mileageafter) values ('kx99', 35000, 39000);
insert into mileage(regno, mileagebefore, mileageafter) values ('iop1123', 23000, 28000);
insert into mileage(regno, mileagebefore, mileageafter) values ('nfg987', 21420, 21620);
insert into mileage(regno, mileagebefore, mileageafter) values ('hyt865', 15000, 18000);
insert into mileage(regno, mileagebefore, mileageafter) values ('mod98', 12000, 12150);
insert into mileage(regno, mileagebefore, mileageafter) values ('fase23', 12000, 12400);
insert into mileage(regno, mileagebefore, mileageafter) values ('gsrd21', 12000, 12050);
insert into mileage(regno, mileagebefore, mileageafter) values ('ng12', 11000, 11150);
insert into mileage(regno, mileagebefore, mileageafter) values ('yjgf23', 1000, 2000);
insert into mileage(regno, mileagebefore, mileageafter) values ('mvx33', 900, 1000);




--insert data into contract
--5 contracts for branch
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (1, 3, 5, 50, DATE '2019-06-25', DATE '2019-06-30', '21 Oconell Street, Dublin');
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (2, 4, 10, 50, DATE '2019-06-10', DATE '2019-06-20', '21 Oconell Street, Dublin'); 
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (3, 5, 20, 20, DATE '2019-06-01', DATE '2019-06-21', '21 Oconell Street, Dublin');
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (4, 6, 29, 30, DATE '2019-06-01', DATE '2019-06-30', '21 Oconell Street, Dublin');
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (5, 7, 12, 30, DATE '2019-06-01', DATE '2019-06-13', '21 Oconell Street, Dublin');

--5 contracts for online rental
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (6, 8, 14, 50, DATE '2020-07-01', DATE '2020-07-15', '22 Long Mile Road, Dulin'); 
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (7, 9, 7, 20, DATE '2020-07-14', DATE '2020-07-07', '22 Long Mile Road, Dulin');
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (8, 10, 11, 30, DATE '2020-07-12', DATE '2020-07-01', '22 Long Mile Road, Dulin');
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (9, 11, 8, 50, DATE '2020-07-10', DATE '2020-07-02', '22 Long Mile Road, Dulin');
insert into contract(contractid, modelid, rentalperiod, fuelamount, pickupdate, returndate, pickuplocation) values (10, 12, 4, 20, DATE '2020-07-15', DATE '2020-07-11', '22 Long Mile Road, Dulin');





--insert data into branchcontract
insert into branchcontract(contractid, branchid) values (1, 1);
insert into branchcontract(contractid, branchid) values (2, 1);
insert into branchcontract(contractid, branchid) values (3, 1);
insert into branchcontract(contractid, branchid) values (4, 1);
insert into branchcontract(contractid, branchid) values (5, 1);




--insert data into customer
insert into customer(custid, name, address, email, age) values (1, 'Alexander Jones', '132 Dublin Road', 'alexj@mail.com', 23);
insert into customer(custid, name, address, email, age) values (2, 'John Clarke', '22 Camden Street', 'johnc@mail.com', 20);
insert into customer(custid, name, address, email, age) values (3, 'Johnatan March', '55 Clontarf Road', 'jm@mail.com', 30);
insert into customer(custid, name, address, email, age) values (4, 'Anna Jones', '44 Temple Bar', 'aj@mail.com', 45);
insert into customer(custid, name, address, email, age) values (5, 'Claire Tate', '99 Donegal Road', 'ct@mail.com', 19);



--insert data into customer_contract
insert into customercontract(contractid, custid) values(1, 1);
insert into customercontract(contractid, custid) values(2, 1);
insert into customercontract(contractid, custid) values(3, 1);
insert into customercontract(contractid, custid) values(4, 2);
insert into customercontract(contractid, custid) values(5, 2);
insert into customercontract(contractid, custid) values(6, 3);
insert into customercontract(contractid, custid) values(7, 3);
insert into customercontract(contractid, custid) values(8, 3);
insert into customercontract(contractid, custid) values(9, 5);
insert into customercontract(contractid, custid) values(10, 5);





--insert data into onlinesalesrepresentative
insert into onlineSalesRepresentative(staffid) values (6);
insert into onlineSalesRepresentative(staffid) values (7);
insert into onlineSalesRepresentative(staffid) values (8);
insert into onlineSalesRepresentative(staffid) values (9);
insert into onlineSalesRepresentative(staffid) values (10);




--insert data into onlinerentalcontract
insert into onlinerentalcontract(contractid, staffid, transactionverified, emailsent) values (6, 6, 'Y', 'Y');
insert into onlinerentalcontract(contractid, staffid, transactionverified, emailsent) values (7, 7, 'Y', 'Y');
insert into onlinerentalcontract(contractid, staffid, transactionverified, emailsent) values (8, 8, 'Y', 'Y');
insert into onlinerentalcontract(contractid, staffid, transactionverified, emailsent) values (9, 9, 'Y', 'Y');
insert into onlinerentalcontract(contractid, staffid, transactionverified, emailsent) values (10, 10, 'Y', 'Y');



--insert data into bill
insert into bill(billid, rentalperiod, dailycost, rentalmileage, totalcost) values (1, 5, 95.99, 4000, 479.95);
insert into bill(billid, rentalperiod, dailycost, rentalmileage, totalcost) values (2, 10, 120.99, 5000, 1200.99);
insert into bill(billid, rentalperiod, dailycost, rentalmileage, totalcost) values (3, 20, 99.99, 200, 1999.8);
insert into bill(billid, rentalperiod, dailycost, rentalmileage, totalcost) values (5, 12, 110.99, 150, 1331.88);
insert into bill(billid, rentalperiod, dailycost, rentalmileage, totalcost) values (6, 14, 100.99, 400, 1413.86);
insert into bill(billid, rentalperiod, dailycost, rentalmileage, totalcost) values (7, 7, 103.99, 50, 727.93);
insert into bill(billid, rentalperiod, dailycost, rentalmileage, totalcost) values (8, 11, 1105.99, 150, 12165.89);








--insert data into customerbill
insert into customerbill(custid, billid) values (1, 1);
insert into customerbill(custid, billid) values (1, 2);
insert into customerbill(custid, billid) values (1, 3);
insert into customerbill(custid, billid) values (3, 6);
insert into customerbill(custid, billid) values (3, 7);
insert into customerbill(custid, billid) values (3, 8);




--1.update the total cost in the bill if the customer exceeds 3000 miles using subquery
update bill 
set totalcost = totalcost + (0.3 * (rentalmileage - 3000))
where rentalmileage in 
(select rentalmileage from bill where rentalmileage > 3000);


--2.query using selection function case to check if exceeded 3000 miles
SELECT billid, rentalmileage,
CASE WHEN rentalmileage < 3000 THEN ' Has not exceeded 3000 miles'
ELSE 'exceeded 3000 miles'
END AS HasExceeded FROM bill;


--3 one INNER join using a GROUP Function 
--show employees who handled branch rentals

select salesrepresentative.staffid as staffid, salesrepresentative.name as salesrep, branchrental.branchid as branchid from 
salesrepresentative inner join branchrental on
salesrepresentative.branchid = branchrental.branchid
group by salesrepresentative.staffid, salesrepresentative.name, branchrental.branchid;


--4.one INNER join using a GROUP Function with a restriction 
--show for each customer with greater than 3000 mileage their bill
select bill.billid, customerbill.custid, bill.rentalmileage 
from bill inner join customerbill on bill.billid = customerbill.billid
group by bill.billid,customerbill.custid, bill.rentalmileage
having bill.rentalmileage > 3000;



--5.One LEFT OUTER Join
--for each car display its mileage. Mileage values are from the mileage table and regno is linking both tables
select regno, mileagebefore, mileageafter from mileage
left outer join cartype using(regNo);



--6.One RIGHT OUTER Join 
--display for each car its car type details
--matching row is regno and right table is cartype
select regno, manufacturer, carmodel , category, fueltype 
from car right outer join cartype using(regno);



--7.Union 
--Here the staff who do branch rentals and online rentals are renturned
select staffid from branchrental
union 
select staffid from onlinesalesrepresentative;


--8.One INTERSECT
--Here the staff who handle online rentals are returned
--common to both tables
select staffid from onlinerentalcontract
intersect 
select staffid from onlinesalesrepresentative;



--9.one view
--this view stores information about customers
create view customers_view as 
select custid, name, email
from customer;

select * from customers_view;

commit;






