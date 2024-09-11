/**
    ch06  :  DML 및 DDL
**/
-- 부서 정보 확인 
select * from department d ;

-- 부서 추가 
INSERT INTO department (dept_no, dept_name)
VALUES ('A5', '전산부');

-- 제품 정보 추가 
INSERT INTO product (product_id, product_name, product_unit,unit_price, stock)
VALUES (91, '연어소스', '박스', 5000, 40);

-- 사원 정보 확인 
select * from employee e ;

-- 사원 정보 추가 
INSERT INTO employee (emp_no, name, eng_name, position, gender, birth_date, hire_date, address, city, region, home_phone, manager_no, dept_id) VALUES
('2024120101', '이미애', 'Lee Mi Ae', '부장', '남', '1972-01-15', '2024-12-01', '서울시 양천구 목동 123', '서울', '서울특별시', '02-2644-4567', NULL, NULL),
('2024120102', '박승진', 'Park seng jin', '부장', '여', '1978-06-20', '2024-12-10', '서울시 양천구 목동 456', '서울', '서울특별시', '02-2645-6543',NULL, NULL),
('2024120103', '김지훈', 'Kim Jihoon', '부장', '여', '1971-11-30', '2024-12-01', '서울시 양천구 목동 789', '서울', '서울특별시', '02-2643-4567', NULL, NULL);

-- 사원 정보 업데이트 
UPDATE employee
SET name = '이은숙'
WHERE emp_id = 47;

select * from product;

-- 제품 정보 업데이트 
UPDATE product
SET product_unit = '병'
WHERE product_id = 91;

-- 제품 정보 업데이트 
UPDATE product
SET unit_price = unit_price * 1.1
   ,stock = stock - 10
WHERE product_id = 91;

-- 제품 정보 삭제 
DELETE FROM product
WHERE product_id = 91;

-- 사원정보 삭제 (조건 :최근에 고용된 사람 중 3명 )
-- SELECT * FROM employee
DELETE FROM employee
JOIN (
    SELECT emp_id
    FROM employee
    ORDER BY hire_date DESC
    LIMIT 3
) AS recent_employees
ON employee.emp_id = recent_employees.emp_id;

-- 제품 정보 추가 제품 아이디가 같으면 업데이트, 아니면 추가 
INSERT INTO product (product_id, product_name, unit_price , stock)
VALUES (92, '불닭볶음면', 6000, 50)
ON CONFLICT (product_id) 
DO UPDATE SET 
    product_name = EXCLUDED.product_name,
    unit_price = EXCLUDED.unit_price,
    stock = EXCLUDED.stock;

-- 고객 주문 요약 테이블  생성 
CREATE TABLE customer_order_summary (
    customer_id CHAR(5) PRIMARY KEY,
    company_name VARCHAR(50),
    order_count INT,
    last_order_date DATE
);

-- insert select 구문으로 요약 테이블 정부 추가 
INSERT INTO customer_order_summary (customer_id, company_name, order_count, last_order_date)
    SELECT c.cust_id
         ,c.company_name
         ,COUNT(*)
         ,MAX(o.order_date)
    FROM customer c
    INNER JOIN orders o ON c.cust_id = o.cust_id
    GROUP BY c.cust_id, c.company_name;

-- 제품 아이디 91번의 가격을 소스 가격의 평균으로 업데이트 
UPDATE product
SET unit_price = (
    SELECT AVG(unit_price)
    FROM product
    WHERE product_name LIKE '%소스%'
)
WHERE product_id = 91;

-- 주문 정보가 있는 사용자의 마일리지 정보를 10% 증가 
UPDATE customer
SET mileage = mileage * 1.1
WHERE cust_id IN (
    SELECT DISTINCT cust_id
    FROM orders
);

-- 고객 정보에서 VIP 고객만 마일리지 점수 1000점 추가 
UPDATE customer
SET mileage = mileage + 1000
FROM mileage_grade mg
WHERE mileage BETWEEN mg.min_mileage AND mg.max_mileage 
  AND mg.grade = 'VIP';

-- 주문 상세에 없는 주문 번호는 모두 삭제 
 SELECT * FROM orders 
-- DELETE FROM orders
WHERE order_id NOT IN (
    SELECT DISTINCT order_id
    FROM order_details
);

-- 주문정보가 없는 고객을 모두 삭제 
select * from customer
-- DELETE FROM customer
JOIN orders
ON customer.cust_id = orders.cust_id
  AND orders.cust_id IS NULL;



-- 사원 뷰 생성: 이름, 전화번호, 입사일, 주소
CREATE OR REPLACE VIEW view_employee AS
SELECT name AS 이름
      ,home_phone AS 전화번호
      ,hire_date AS 입사일
      ,address AS 주소
FROM employee;

-- 사원 뷰 확인
SELECT * FROM view_employee;


-- 제품별 주문 수량 합계 뷰 생성
CREATE OR REPLACE VIEW view_product_order_quantity_sum AS
SELECT p.product_name AS 제품명
      ,SUM(o.quantity) AS 주문수량합
FROM product p
INNER JOIN order_details o
ON p.product_id = o.product_id
GROUP BY p.product_name;

-- 뷰 확인
SELECT * FROM view_product_order_quantity_sum;


-- 여성 사원 정보를 담은 뷰 생성
CREATE OR REPLACE VIEW view_female_employees AS
SELECT name AS 이름
      ,home_phone AS 전화번호
      ,hire_date AS 입사일
      ,address AS 주소
      ,gender AS 성별
FROM employee
WHERE gender = '여';


-- 뷰 확인
SELECT * FROM view_female_employees;
