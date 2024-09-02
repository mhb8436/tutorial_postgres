/**
    ch04  :  집계함수 
**/

-- 회원(customer) 테이블에서 전체 행갯수를 구해보세
SELECT COUNT(*)
      ,COUNT(cust_id)
      ,COUNT(city)
      ,COUNT(region)
FROM customer;

-- 회원(customer) 테이블에서 마일리지 총합, 평균, 최소, 최대 구하기 
SELECT SUM(mileage)
      ,AVG(mileage)
      ,MIN(mileage)
      ,MAX(mileage)
FROM customer;

-- 회원(customer) 테이블에서 도시가 서울인 사람 중에서 마일리지 총합, 평균, 최소, 최대 구하기 
SELECT SUM(mileage)
      ,AVG(mileage)
      ,MIN(mileage)
      ,MAX(mileage)
FROM customer
WHERE city like '서울%';

-- 회원(customer) 테이블에서 도시 별로 회원명수, 평균 마일리지 구하기 
SELECT city
      ,COUNT(*) AS customer_count
      ,AVG(mileage) AS average_mileage
FROM customer
GROUP BY city;

-- 회원(customer) 테이블에서 직급별 도시별로 회원 명수, 평균마일리지 구하기 
SELECT contact_position 
      ,city
      ,COUNT(*) AS customer_count
      ,AVG(mileage) AS average_mileage
FROM customer
GROUP BY contact_position
        ,city
ORDER BY contact_position, city;

-- 회원(customer) 테이블에서 도시 별로 전체 고객수 및 평균 마일리지를 구하기(조건 : 고객이 10명 이상인 경우 )
SELECT city
      ,COUNT(*) AS customer_count
      ,AVG(mileage) AS average_mileage
FROM customer
GROUP BY city
HAVING COUNT(*) >= 10;

-- 회원(customer) 테이블에서 도시별 총 마일리를 구하기 (조건 : 회사이름에 T 자가 들어가고 도시별 마일리지가 총합이 100 이상) 
SELECT city
      ,SUM(mileage)
FROM customer
WHERE company_name LIKE '%T%'
GROUP BY city
HAVING SUM(mileage) >= 100;

-- 회원(customer) 테이블에서 도시별로 고객수 및 평균 마일리지를 구하기 (조건 : 지역(region)이 NULL이 아님)
SELECT city
      ,COUNT(*) AS customer_count
      ,AVG(mileage) AS average_mileage
FROM customer
WHERE region is NOT NULL
GROUP BY city;

-- 회원(customer) 테이블에서 직급별 도시 별 고객수를 구하기 (조건 : 직급이 대표인 경우 )
SELECT contact_position
      ,city
      ,COUNT(*) AS customer_count
FROM customer
WHERE contact_position LIKE '%대표%'
GROUP BY contact_position
        ,city;

-- 회원(customer) 테이블에서 직급별 지역별 고객수를 구하기 (조건 : 직급이 대표인 경우 )
SELECT region
      ,COUNT(*) AS customer_count
FROM customer
WHERE contact_position like '%대표%'
GROUP BY region;

-- 사원(employee) 테이블에서 이름을 콤마(,)로 연결하여 출력하기  
SELECT STRING_AGG(name, ', ') AS names
FROM employee;

-- 회원(customer) 테이블에서 지역을 콤마(,)로 연결하여 출력하기 
SELECT STRING_AGG(DISTINCT region, ', ') AS regions
FROM customer;


-- 회원(customer) 테이블에서 도시별 회사이름을 콤마(,)로 연결하여 출력하기  
SELECT city
      ,STRING_AGG(company_name, ', ') AS customer_companies
FROM customer
GROUP BY city;

-- 회원(customer) 테이블에서 고객의 도시 갯수와 중복을 제거한 도시 개수를 출력하기 
SELECT COUNT(city) AS total_city_count
      ,COUNT(DISTINCT city) AS distinct_city_count
FROM customer;

-- 주문 (orders) 테이블에서 년도 별 주문 갯수를 출력하기  
SELECT EXTRACT(YEAR FROM order_date) AS order_year
       ,COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date);

-- 주문 (orders) 테이블에서 년도 별, 분기 별 주문갯수 출력하기 
SELECT EXTRACT(YEAR FROM order_date) AS order_year
      ,EXTRACT(QUARTER FROM order_date) AS quarter
      ,COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
        ,EXTRACT(QUARTER FROM order_date)
ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date);


-- 주문 (orders) 테이블에서 주문 월별로 주문 갯수를 구하기  
SELECT EXTRACT(MONTH FROM order_date) AS order_month
      ,COUNT(*) AS order_count
FROM orders
WHERE required_date < shipped_date
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(MONTH FROM order_date);


-- 제품 (product) 테이블에서 우유인 상품의 재고(stock)개수를 구하기  
SELECT product_name
      ,SUM(stock) AS total_stock
FROM product
WHERE product_name LIKE '%우유%'
GROUP BY product_name;

-- 고객 (customer) 테이블에서 마일리지가 100이상이면 VIP 고객, 아니면 일반고객 인데 VIP고객과 일반 고객 별로 회원수와 평균 마일리지를 구해보세요   
SELECT CASE
           WHEN mileage >= 100 THEN 'VIP고객'
           ELSE '일반고객'
       END AS customer_type
      ,COUNT(*) AS customer_count
      ,AVG(mileage) AS average_mileage
FROM customer
GROUP BY CASE
	         WHEN mileage >= 100 THEN 'VIP고객'
	         ELSE '일반고객'
	     END;

