/**
    ch02  : 기본 SELECT 문
**/

-- 고객(customer) 전체를 검색하세요
SELECT *
FROM customer;

-- 고객(customer) 테이블에서  고객코드, 연락처, 담당자명, 회사명, 마일리지, 마일리지에서 10% 추가된 마일리지를 검색하세요
SELECT cust_id 
       ,contact_name	
       ,company_name
       ,mileage AS points
       ,mileage * 1.1 AS "10%추가"
FROM customer;

-- 고객(customer) 테이블에서  고객코드, 담당자명, 마일리지를 출력하는데, 마일리지가 10000 점이상인 고객만 검색하세요
SELECT cust_id
       ,contact_name
       ,mileage
FROM customer
WHERE mileage >= 100;

-- 고객(customer) 테이블에서  고객코드, 담당자명, 도시, 마일리지를 출력하는데, 도시가 서울인 고객만 검색하세요. 마일리지 역순으로 출력하세요
SELECT cust_id
       ,contact_name
       ,city
       ,mileage AS points
FROM customer
WHERE city = '서울'
ORDER BY mileage DESC;

-- 고객(customer) 테이블에서 3명만 검색하세요
SELECT *
FROM customer
LIMIT 3;

-- 고객(customer) 테이블에서 마일리지 역순으로 정렬 후에 3명만 출력하세요
SELECT *
FROM customer
ORDER BY mileage DESC
LIMIT 3;

-- 고객(customer) 테이블에서 도시이름만 중복 없이 출력하세요
SELECT DISTINCT city
FROM customer;

-- 산술 연산자
SELECT 33 + 5 AS addition
      ,33 - 5 AS subtraction
      ,33 * 5 AS multiplication
      ,33 / 5::FLOAT AS float_division
      ,33 / 5 AS integer_division
      ,33 % 5 AS remainder1
      ,MOD(33, 5) AS remainder2;

-- 비교 연산자
SELECT 33 >= 5 AS "greater_than_or_equal"
      ,33 <= 5 AS "less_than_or_equal"
      ,43 > 23 AS "greater_than"
      ,43 < 23 AS "less_than"
      ,43 = 43 AS "equal"
      ,43 != 23 AS "not_equal"
      ,43 <> 23 AS "not_equal_alternative";

-- 고객 테이블에서 직위가 대표가 아닌 고객만 검색하세요
SELECT *
FROM customer
WHERE contact_position <> '대표';

-- 고객 테이블에서 도시가 부산이고, 마일리지가 1000 이하인 사람만 출력하세요
SELECT *
FROM customer
WHERE city = '부산'
AND mileage < 1000;

-- 고객 테이블에서 도시가 부산인 사람과 마일리지가 1000 이하인 사람을 출력하세요
SELECT cust_id
       ,contact_name
       ,mileage
       ,city
FROM customer
WHERE city = '부산'
UNION
SELECT cust_id
       ,contact_name
       ,mileage
       ,city
FROM customer
WHERE mileage < 100
ORDER BY 1;

update customer set region = null where cust_id = 4;

update customer set region = '' where cust_id = 13;

-- 고객 중에서 지역데이터가 없는 사람을 출력하세요
SELECT *
FROM customer
WHERE region IS NULL;

-- 고객 중에서 지역데이터가 ''인 사람을 출력하세요
SELECT *
FROM customer
WHERE region = '';

-- 고객 테이블에서 지역이 '' 고객의 지역을 모두 NULL로 수정하세요
UPDATE customer
SET region = NULL
WHERE region = '';

-- 고객 테이블에서 직위가 대표이거나 사원인 사람을 출력하세요
SELECT cust_id
       ,contact_name
       ,contact_position
FROM customer
WHERE contact_position = '대표'
OR contact_position = '사원';

-- 고객 테이블에서 직위가 대표이거나 사원인 사람을 출력하세요
SELECT cust_id
       ,contact_name
       ,contact_position
FROM customer
WHERE contact_position IN ('사원', '대표');

-- 고객 테이블에서 마일리지가 100 이상이고 200 이하인 고객만 출력하세요
SELECT contact_name
       ,mileage
FROM customer
WHERE mileage >= 100
AND mileage <= 200;

-- 고객 테이블에서 마일리지가 100000 이상이고 200000 이하인 고객만 출력하세요
SELECT contact_name
       ,mileage
FROM customer
WHERE mileage BETWEEN 100 AND 200;

-- 고객 테이블에서 지역이 광역시인 사람을 출력하세요 
SELECT *
FROM customer
WHERE region LIKE '%광역시';


-- 고객 테이블에서 city가 서울이고, 마일리지가 15000 부터 20000 이하인 고객만 출력하세요
SELECT *
FROM customer
WHERE city LIKE '서울%'
AND mileage BETWEEN 150 AND 200;

-- 고객 테이블에서 region이 중복이 없도록 출력하세요
SELECT DISTINCT region ,city
FROM customer
ORDER BY 1, 2;

-- 고객 테이블에서 city가 서울 대전이고, 직위가 대표이거나 사원인 고객만 출력하세요
SELECT *
FROM customer
WHERE city IN ('서울', '대전')
AND (contact_position LIKE '%대표%' OR contact_position LIKE '%사원%');

-- 고객 테이블에서 region에 특별시 또는 광역시가 포함된 고객을 마일리지 역순으로 출력하세요
SELECT *
FROM customer
WHERE NOT (city LIKE '%광역시' OR city LIKE '%특별시')
ORDER BY mileage DESC
LIMIT 3;

-- 고객 테이블에서 지역이 NULL이 아니고, 담당자 직위가 대표가 아닌 사람읆 모두 출력하세요
SELECT *
FROM customer
WHERE region IS NOT NULL
AND contact_position <> '대표';