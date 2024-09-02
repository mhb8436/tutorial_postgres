/**
    ch03  : 기본 함수
**/

-- 문자열 길이 세기 
SELECT LENGTH('HELLO') AS length_hello
      ,CHAR_LENGTH('HELLO') AS char_length_hello
      ,LENGTH('안녕') AS length_annyung
      ,CHAR_LENGTH('안녕') AS char_length_annyung;

-- 문자열 붙이기 
SELECT CONCAT('DREAMS', 'COME', 'TRUE') AS concatenated
      ,CONCAT_WS('-', '2023', '01', '29') AS date_with_dash;

-- 문자열 자르기 
SELECT LEFT('SQL 수업', 3) AS left_string
      ,RIGHT('SQL 수업', 4) AS right_string
      ,SUBSTRING('SQL 수업' FROM 2 FOR 5) AS substr_2_5
      ,SUBSTRING('SQL 수업' FROM 2) AS substr_2;

-- 문자열  분리하기 
SELECT SPLIT_PART('서울시 양천구 신정동', ' ', 1) AS part_1
      ,SPLIT_PART('서울시 양천구 신정동', ' ', 3) AS part_3;

-- 문자열 패딩하기 
SELECT LPAD('SQL', 10, '#') AS lpad_string
      ,RPAD('SQL', 5, '*') AS rpad_string;

-- 문자열 트림하기 
SELECT LENGTH(TRIM(LEADING FROM ' SQL ')) AS length_trim_leading
      ,LENGTH(TRIM(TRAILING FROM ' SQL ')) AS length_trim_trailing
      ,LENGTH(TRIM(BOTH FROM ' SQL ')) AS length_trim_both;

-- 문자열 트림하기 
SELECT TRIM(BOTH 'abc' FROM 'abcSQLabcabc') AS trim_both
      ,TRIM(LEADING 'abc' FROM 'abcSQLabcabc') AS trim_leading
      ,TRIM(TRAILING 'abc' FROM 'abcSQLabcabc') AS trim_trailing;

-- 문자열 위치 찾기 
SELECT POSITION('RUST' IN 'SQL JAVA RUST') AS field_position
      ,POSITION('RUST' IN 'SQL,JAVA,RUST') AS find_in_set
      ,POSITION('인생' IN '너의 인생을 살아라') AS instr_position
      ,POSITION('인생' IN '너의 인생을 살아라') AS locate_position;

-- 배열 위치 찾기
SELECT (ARRAY['SQL', 'JAVA', 'RUST'])[2] AS elt_result;

-- 문자열 반복 
SELECT REPEAT('*', 5) AS repeated_string;

-- 문자열 대체  
SELECT REPLACE('010.1234.5678', '.', '-') AS replaced_string;

-- 문자열 역순 정렬 
SELECT REVERSE('OLLEH') AS reversed_string;

-- 숫자 올림, 내림, 반올림, 자르기 
SELECT CEIL(123.56) AS ceiling_value
      ,FLOOR(123.56) AS floor_value
      ,ROUND(123.56) AS rounded_value
      ,ROUND(123.56, 1) AS rounded_value_1
      ,TRUNC(123.56, 1) AS truncated_value;

-- 숫자 절대값 부호화 
SELECT ABS(-120) AS abs_negative
      ,ABS(120) AS abs_positive
      ,SIGN(-120) AS sign_negative
      ,SIGN(120) AS sign_positive;

-- 몫과 나머지 
SELECT 103 % 4 AS remainder_mod
      ,MOD(103, 4) AS remainder_mod_function;

-- 제곱근, 랜덤, 라운드
SELECT POWER(2, 3) AS power_result
      ,SQRT(16) AS square_root
      ,RANDOM() AS random_value
      ,ROUND(RANDOM() * 100) AS rounded_random_value;

-- 현재날짜, 현재 시간
SELECT NOW() AS current_datetime
      ,CURRENT_DATE AS current_date
      ,CURRENT_TIME AS current_time;

-- 현재날짜에서 년, 분기, 월, 일, 시, 분, 초 추출
SELECT NOW() AS current_datetime
      ,EXTRACT(YEAR FROM NOW()) AS year
      ,EXTRACT(QUARTER FROM NOW()) AS quarter
      ,EXTRACT(MONTH FROM NOW()) AS month
      ,EXTRACT(DAY FROM NOW()) AS day
      ,EXTRACT(HOUR FROM NOW()) AS hour
      ,EXTRACT(MINUTE FROM NOW()) AS minute
      ,EXTRACT(SECOND FROM NOW()) AS second;

-- 날짜 차이 계산 
SELECT NOW() AS current_datetime
      ,DATE_PART('day', '2025-11-20'::date - NOW()) AS date_diff
      ,DATE_PART('day', NOW() - '2025-11-20'::date) AS reverse_date_diff
      ,DATE_PART('year', '2025-11-20'::date - NOW()) AS years_diff
      ,DATE_PART('month', '2025-11-20'::date - NOW()) AS months_diff
      ,DATE_PART('day', '2025-11-20'::date - NOW()) AS days_diff;

-- 현재 날짜에서 이후 날짜 개산 
SELECT NOW() AS current_datetime
      ,NOW() + INTERVAL '20 days' AS date_plus_20_days
      ,NOW() + INTERVAL '20 months' AS date_plus_20_months
      ,NOW() - INTERVAL '20 hours' AS date_minus_20_hours;

-- 월 말일 계산, 지금까지 지난 일자 계산, 월이름 계산, 요일 출력 
SELECT NOW() AS current_datetime
      ,DATE_TRUNC('MONTH', NOW()) + INTERVAL '1 MONTH - 1 day' AS last_day_of_month
      ,EXTRACT(DOY FROM NOW()) AS day_of_year
      ,TO_CHAR(NOW(), 'Month') AS month_name
      ,EXTRACT(DOW FROM NOW()) AS weekday;

-- 형변환 
SELECT CAST('1' AS INTEGER) AS cast_integer
      ,CAST(2 AS CHAR) AS cast_char
      ,'1'::INTEGER AS convert_integer
      ,2::CHAR AS convert_char;

-- CASE WHEN 
SELECT CASE WHEN 12500 * 450 > 5000000 THEN '초과달성' ELSE '미달성' END AS achievement_status;

-- NULLIF, COALESCE
SELECT COALESCE(1, 0) AS ifnull_1
      ,COALESCE(NULL, 0) AS ifnull_null
      ,COALESCE(NULLIF(1 / NULLIF(0, 0), NULL), 1) AS ifnull_division_by_zero;


-- NULLIF
SELECT NULLIF(12 * 10, 120) AS nullif_1
      ,NULLIF(12 * 10, 1200) AS nullif_2;

-- CASE WHEN
SELECT CASE WHEN 12500 * 450 > 5000000 THEN '초과달성'
            WHEN 2500 * 450 > 4000000 THEN '달성'
            ELSE '미달성'
       END AS achievement_status;


-- [문제 1]  customer 테이블에서 회사이름을 맨앞 두글자를 *로 변경하고, 전화번호 앞자리의 0번을 삭제하고 )를 -로 변경하여 출력하세
SELECT company_name
      ,CONCAT('**', SUBSTRING(company_name FROM 3)) AS cust_company2
      ,phone
      ,REPLACE(SUBSTRING(phone FROM 2), ')', '-') AS phone_number2
FROM customer;


-- [문제 2] order_details 테이블에서 주문 총액,할인율이 적용된 금액, 최종주문금액을 출력하세요 
SELECT order_id
      ,unit_price * quantity AS order_amount
      ,TRUNC((unit_price * quantity * discount)::integer, -1) AS discount_amount
      ,(unit_price * quantity) - TRUNC((unit_price * quantity * discount)::integer, -1) AS final_order_amount
FROM order_details;


-- [문제 3] 사원(employee ) 테이블에서 나이, 고용한 일자로부터 지금까지 지난 일수, 고용일자로부터 500일ㅇ이 지난날짜를 출력하세요 
SELECT name
      ,birth_date 
      ,DATE_PART('year', NOW() - birth_date) AS age
      ,hire_date
      ,DATE_PART('day', NOW() - hire_date) AS days_since_hired
      ,hire_date + INTERVAL '500 days' AS days_after_500
FROM employee;

-- [문제 4]회원(customer) 테이블에서 도시컬럼에 특별시 광역시면 대도시 아니면 도시를 출력하고, 마일리지가 200 이상이면 VVIP 고객, 100이상이면 VIP, 아니면 일반고객으로 출력하세 
SELECT contact_name
      ,company_name 
      ,city
      ,CASE WHEN city LIKE '%특별시' OR city LIKE '%광역시' THEN '대도시' ELSE '도시' END AS city_type
      ,mileage
      ,CASE WHEN mileage >= 200 THEN 'VVIP 고객'
            WHEN mileage >= 100 THEN 'VIP 고객'
            ELSE '일반 고객'
       END AS mileage_category
FROM customer;

-- [문제 5] 주문(orders) 테이블에서 주문 날짜, 주문 년도, 주문 분기, 주문 월, 주문 일자, 주문 요일(숫자), 주문 요일을 출력하세요 
SELECT order_id
      ,cust_id
      ,order_date
      ,EXTRACT(YEAR FROM order_date) AS order_year
      ,EXTRACT(QUARTER FROM order_date) AS order_quarter
      ,EXTRACT(MONTH FROM order_date) AS order_month
      ,EXTRACT(DAY FROM order_date) AS order_day
      ,EXTRACT(DOW FROM order_date) AS order_weekday
      ,CASE EXTRACT(DOW FROM order_date) WHEN 0 THEN 'Sunday'
                                        WHEN 1 THEN 'Monday'
                                        WHEN 2 THEN 'Tuesday'
                                        WHEN 3 THEN 'Wednesday'
                                        WHEN 4 THEN 'Thursday'
                                        WHEN 5 THEN 'Friday'
                                        ELSE 'Saturday' end as order_week
from orders;
      
