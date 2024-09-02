/**
    ch05  :  조인 및 서브쿼리
**/

--사원(employee) 테이블과 부서(department) 테이블을 조인해서 부서번호, 부서명, 사원명, 사원번호를 출력하세요 (조건 사원명 : 홍길동)
SELECT d.dept_id
      ,d.dept_name
      ,e.name
      ,e.dept_id
FROM department d
CROSS JOIN employee e
WHERE e.name = '홍길동';


--사원(employee) 테이블과 부서(department) 테이블을 조인해서 부서번호, 부서명, 사원명, 사원번호를 출력하세요 (조건 사원명 : 홍길동)
SELECT d.dept_id
      ,d.dept_name
      ,e.name
      ,e.dept_id
FROM department d
    ,employee e
WHERE e.name = '홍길동';

--사원(employee) 테이블과 부서(department) 테이블을 조인해서 사원번호, 직위, 부서아이디, 부서명을 출력하세요 (조건 사원명 : 홍길동)
SELECT e.emp_id
      ,e.position
      ,e.dept_id
      ,d.dept_name
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id
WHERE e.name = '홍길동';

--사원(employee) 테이블과 부서(department) 테이블을 조인해서 사원번호, 직위, 부서아이디, 부서명을 출력하세요 (조건 사원명 : 홍길동)
SELECT e.emp_id
      ,e.position
      ,e.dept_id
      ,d.dept_name
FROM employee e
    ,department d
WHERE e.dept_id = d.dept_id
AND e.name = '홍길동';

--고객 테이블(customer)과 주문 테이블(orders)을 고객명, 담당자명, 회사명, 주문건수를 출력하세요 주문건수가 많은 순으로 출력하세요 
SELECT c.cust_id
      ,c.contact_name
      ,c.company_name
      ,COUNT(*) AS order_count
FROM customer c
INNER JOIN orders o
ON c.cust_id = o.cust_id
GROUP BY c.cust_id
      ,c.contact_name
      ,c.company_name
ORDER BY COUNT(*) DESC;

--고객 테이블(customer)과 주문 테이블(orders)을 고객명, 담당자명, 회사명, 주문건수를 출력하세요 주문건수가 많은 순으로 출력하세요 
SELECT c.cust_id
      ,c.contact_name
      ,c.company_name
      ,COUNT(*) AS order_count
FROM customer c
    ,orders o
WHERE c.cust_id = o.cust_id
GROUP BY c.cust_id
      ,c.contact_name
      ,c.company_name
ORDER BY COUNT(*) DESC;

-- 고객 테이블(customer)과 주문 테이블(orders)과 주문 상세 테이블(order_details) 테이블을 조인하여 
-- 고객 아이디,담당자명,회사명, 주문 총액 을 출력하세요. 주문 총액 순으로 정렬하세요  
SELECT c.cust_id
      ,c.contact_name
      ,c.company_name
      ,SUM(od.quantity * od.unit_price) AS total_order_amount
FROM customer c
INNER JOIN orders o
ON c.cust_id = o.cust_id
INNER JOIN order_details od
ON o.order_id = od.order_id
GROUP BY c.cust_id
      ,c.contact_name
      ,c.company_name
ORDER BY total_order_amount DESC;

-- 고객 테이블(customer)과 주문 테이블(orders)과 주문 상세 테이블(order_details) 테이블을 조인하여 
-- 고객 아이디,담당자명,회사명, 주문 총액 을 출력하세요. 주문 총액 순으로 정렬하세요  
SELECT c.cust_id
      ,c.contact_name
      ,c.company_name
      ,SUM(od.quantity * od.unit_price) AS total_order_amount
FROM customer c
    ,orders o
    ,order_details od
WHERE c.cust_id = o.cust_id
AND o.order_id = od.order_id
GROUP BY c.cust_id
      ,c.contact_name
      ,c.company_name
ORDER BY total_order_amount DESC;


-- 고객 테이블(customer)과 마일리지 등급(mileage_grade) 테이블을 조인해서 
-- 고객 아이디,회사명,담당자명, 마일리지, 등급을 출력하세요  (조건 : 담당자명 '남성우' ) 
SELECT c.cust_id
      ,c.company_name
      ,c.contact_name
      ,c.mileage
      ,mg.grade 
FROM customer c
INNER JOIN mileage_grade mg
ON c.mileage BETWEEN mg.min_mileage AND mg.max_mileage
WHERE c.contact_name = '남성우';

-- 고객 테이블(customer)과 마일리지 등급(mileage_grade) 테이블을 조인해서 
-- 고객 아이디,회사명,담당자명, 마일리지, 등급을 출력하세요 (조건 : 담당자명 '남성우' )
SELECT c.cust_id
      ,c.company_name
      ,c.contact_name
      ,c.mileage
      , mg.grade
FROM customer c
    ,mileage_grade mg
WHERE c.mileage BETWEEN mg.min_mileage AND mg.max_mileage
AND c.contact_name = '남성우';

--사원(employee) 테이블과 부서(department) 테이블을 외부 조인해서 사원번호,사원명, 부서명을 출력하세요 부서가 없으면 NULL 로 출력 
SELECT e.emp_id
      ,e.name
      ,d.dept_name
FROM employee e
LEFT OUTER JOIN department d
ON e.dept_id = d.dept_id
WHERE e.gender = '여';

--사원(employee) 테이블과 부서(department) 테이블을 외부 조인해서 사원번호,사원명, 부서명을 출력하세요 부서가 없으면 NULL 로 출력(조건 : 부서아이디가 NULL 인경우 )
SELECT e.name
      ,d.*
FROM employee e
LEFT OUTER JOIN department d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;


--사원(employee) 테이블을 조인하여 사워아이디, 사원명,부서장 아이디, 부서장명 을 출력하세요 
SELECT e.emp_id
      ,e.name
      ,supervisor.emp_id AS "Supervisor Employee ID"
      ,supervisor.name AS "Supervisor Name"
FROM employee e
INNER JOIN employee AS supervisor
ON e.manager_no = supervisor.emp_id;

--사원(employee) 테이블을 조인하여 사원 아이디, 사원명,부서장 아이디, 부서장명 을 출력하세요 
SELECT e.emp_id
      ,e.name
      ,supervisor.emp_id AS "Supervisor Employee ID"
      ,supervisor.name AS "Supervisor Name"
FROM employee e
    ,employee AS supervisor
WHERE e.manager_no = supervisor.emp_id;

--사원(employee) 테이블을 조인하여 사원 아이디, 사원명,부서장 아이디, 부서장명 을 출력하세요 부서장이 없으면 NULL 출력 
SELECT e.name AS name
      ,e.position
      ,supervisor.name AS supervisor_name
FROM employee AS supervisor
RIGHT OUTER JOIN employee e
ON e.manager_no = supervisor.emp_id
ORDER BY supervisor_name;

-- 고객 (customer) 테이블에 최대 마일리지를 고객의 고객아이디, 회사명, 담당자명, 마일리지를 출력  
SELECT cust_id
      ,company_name
      ,contact_name
      ,mileage
FROM customer
WHERE mileage = (SELECT MAX(mileage)
                FROM customer
               );

-- 고객 (customer) 테이블에서 주문번호가 13번인 고객의 정보를 출력하세요 
SELECT company_name
      ,contact_name
FROM customer
WHERE cust_id = (SELECT cust_id
                FROM orders
			    WHERE order_id =13
               );

-- 고객 (customer) 테이블에서 주문번호가 13번인 고객의 정보를 출력하세요 
SELECT c.company_name
      ,c.contact_name
FROM customer c
INNER JOIN orders o
ON c.cust_id = o.cust_id
WHERE o.order_id = 13;

-- 고객 (customer) 테이블에서 도시가 부산인 고객 중에서 최소 마일리지보다 큰 고객 정보를 출력  
SELECT contact_name
      ,company_name
      ,mileage
FROM customer
WHERE mileage > (SELECT MIN(mileage)
                FROM customer
                WHERE city like '%부산%'
               );

-- 고객 (customer) 테이블에서 도시가 부산인 고객의 주문 건수를 주문 테이블(orders) 에서 구하시오 
SELECT COUNT(*) AS order_count
FROM orders
WHERE cust_id IN (SELECT cust_id
                 FROM customer
                 WHERE city like '%부산%'
                );

-- 고객 (customer) 테이블에서 도시가 부산인 마일리지 보다큰 모든 고객의 정보를 출력  
SELECT contact_name
      ,company_name
      ,mileage
FROM customer
WHERE mileage > ANY (SELECT mileage
                    FROM customer
                    WHERE city like '%부산%'
                   );

-- 고객 (customer) 테이블에서 도시가 부산인 마일리지 보다큰 모든 고객의 정보를 출력  
SELECT contact_name
       ,company_name
       ,mileage
FROM customer
WHERE mileage > ALL (SELECT AVG(mileage)
                    FROM customer
                    GROUP BY region
                   );

-- 주문 테이블과 고객 테이블에서 주문 보가 있는 고객의 정보를 출력하세요 
SELECT cust_id
      ,company_name
FROM customer
WHERE EXISTS (SELECT 1
              FROM orders
              WHERE cust_id = customer.cust_id
              );

-- 주문 테이블과 고객 테이블에서 주문 보가 있는 고객의 정보를 출력하세요 
SELECT cust_id
      ,company_name
FROM customer
WHERE cust_id IN (SELECT DISTINCT cust_id
                 FROM orders
                );

-- 주문 테이블과 고객 테이블에서 주문 보가 있는 고객의 정보를 출력하세요 
SELECT DISTINCT c.cust_id
               ,c.company_name
FROM customer c
INNER JOIN orders o
ON c.cust_id = o.cust_id;

-- 고객 테이블(customer) 에서 도시별 평균 마일리지를 구하세요 (조건 : 고객의 평균 마일리지보타 큰 경우에만) 
SELECT city
      ,AVG(mileage) AS avg_mileage
FROM customer
GROUP BY city
HAVING AVG(mileage) > (SELECT AVG(mileage)
                      FROM customer
                     );

-- 고객 테이블(customer) 도시별 평균 마일리와 도시 평균 마일리지 고객의 평균 마일리지 차이를 구하시오 
SELECT c.contact_name
      ,c.company_name
      ,c.mileage
      ,c.city
      ,city_avg.avg_mileage
      ,city_avg.avg_mileage - c.mileage AS difference
FROM customer c
INNER JOIN (
    SELECT city
          ,AVG(mileage) AS avg_mileage
    FROM customer
    GROUP BY city
) city_avg
ON c.city = city_avg.city;

-- 고객 테이블(customer) 도시별 평균 마일리와 도시 평균 마일리지 고객의 평균 마일리지 차이를 구하시오 
WITH city_summary AS (
    SELECT city
          ,AVG(mileage) AS avg_mileage
    FROM customer
    GROUP BY city
)
SELECT c.contact_name
      ,c.company_name
      ,c.mileage
      ,c.city
      ,cs.avg_mileage
      ,cs.avg_mileage - c.mileage AS difference
FROM customer c
INNER JOIN city_summary cs
ON c.city = cs.city;

-- 고객 테이블(customer) 과 주문 테이블(orders)에서 고객별로 가장 최근 주문일자를 구해보세요  
SELECT cust_id
      ,contact_name
      ,(SELECT MAX(order_date)
        FROM orders
        WHERE orders.cust_id = customer.cust_id
       ) AS last_order_date
FROM customer;


-- 사원 테이블(employee) 에서 사원번호, 사원명, 매니저 번호, 매니저 이름을 출력하세  
SELECT emp_id
      ,name
      ,manager_no 
      ,(SELECT name
        FROM employee AS supervisor
        WHERE supervisor.emp_id = e.manager_no 
       ) AS supervisor_name
FROM employee e;

-- 고객 테이블(customer) 에서 도시 별 최대 마일리지를 가진 고객 정보를 출력하세요 
SELECT city
      ,contact_name
      ,company_name
      ,mileage
FROM customer
WHERE (city, mileage) IN (SELECT city, MAX(mileage)
                       FROM customer
                       GROUP BY city);



