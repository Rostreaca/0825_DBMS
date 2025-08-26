/*
     함수 < FUNCTION >

     자바로 따지면 메소드
     전달된 값을 가지고 계산된 결과를 반환해준다
     
     - 단일행 함수
     - 그룹 함수
*/
--------------------------------------------- < 단일행 함수 >----------------------------------------------------

/*
 * < 문자열과 관련된 함수 >
 * LENGTH / LENGTHB 
 * 
 * STR : '문자열' / 문자열이 들어가있는 컬럼
 * 
 * "equals".length(); <-- 얘랑 똑같음
 * - LENGTH(STR) : 전달된 문자열의 글자 수 반환
 * - LENGTHB(STR) : 전달된 문자열의 바이트 수 반환
 * 
 * 결과는 NUMBER(오라클은 정수 실수 구분 안함)타입
 * 
 * 한글 : 'ㄱ', 'ㅏ', '강' => 한글자당 3Byte
 * 숫자, 영어, 특수문자 => 한 글자당 1Byte
 */
SELECT
       LENGTH('오라클!')
     , LENGTHB('오라클!')
  FROM
       --EMPLOYEE;
       DUAL;--가상테이블(DUMMY TABLE)

       
SELECT 
       EMAIL
     , LENGTH(EMAIL)
  FROM
       EMPLOYEE;
-----------------------------------------------------------
/*
 * INSTR
 * 
 * - INSTR(STR) : 문자열로부터 특정 문자의 위치값 반환
 * 
 * INSTR(STR, '특정 문자', 찾을위치의 시작값, 순번)
 * 
 * 결과값은 NUMBER 타입으로 반환
 * 찾을 위치의 시작값과 순번은 생략이 가능
 * 
 * 찾을 위치의 시작값
 * 1 : 앞에서부터 찾겠다.(기본값)
 * -1 : 뒤에서부터 찾겠다.
 * 
 */

SELECT 
       INSTR('AABAACAABBAA', 'CAA')
  FROM
       DUAL;

SELECT 
       INSTR('AABAACAABBAA', 'B', -1)
  FROM
       DUAL; -- 뒤에서부터 첫 번째 'B'가 앞에서부터 몇 번째인지
       
SELECT
       INSTR('AABAACAABBAA', 'B', 1, 3)
  FROM
       DUAL; -- 앞에서부터 세 번째 'B'가 앞에서부터 몇 번째인지
       
       
SELECT 
       INSTR(EMAIL, '@') "@의위치"
  FROM
       EMPLOYEE;
-------------------------------------------------------------------
/*
 * SUBSTR
 * 
 * - SUBSTR(STR, POSITION, LENGTH) : 문자열로부터 특정 문자열을 추출해서 반환
 * 
 * - STR : '문자열' 또는 문자타입 컬럼 값
 * - POSITION : 문자열 추출 시작위치값(POSITION번째 문자부터 추출) -> 음수도 가능
 * - LENGTH : 추출할 문자 개수(생략 시 끝까지라는 의미)
 * 
 * 
 * 
 */
SELECT
       SUBSTR('KH정보교육원', 3)
  FROM
       DUAL;

SELECT
       SUBSTR('KH정보교육원', 3, 2)
  FROM
       DUAL;

SELECT
       SUBSTR('KH정보교육원', -3, 2)
  FROM
       DUAL; -- POSITION이 음수일 경우 뒤에서 N번째 부터 추출하겠다 라는 의미
       
-- EMPLOYEE 테이블로부터 사원명과 이메일컬럼과 EMAIL컬럼에서의 아이디값만 추출해서 조회
       
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL,1,INSTR(EMAIL,'@') -1)
  FROM
       EMPLOYEE;

SELECT
       EMP_NAME
     , SUBSTR(EMP_NO,8,1)
  FROM
       EMPLOYEE;
-- 남성 사원들만 이름을 조회
SELECT 
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       SUBSTR(EMP_NO, 8, 1) = 1;
----------------------------------------------------------------------------
/*
 * LPAD / RPAD
 * 
 * - LPAD / RPAD(STR, 최종적으로 반환할 문자의 길이(바이트), 패딩할 문자)
 * : 인자로 전달한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여서 N길이만큼의 문자열 반환
 * 
 * 결과값은 CHARACTER타입으로 반환
 * 덧붙이고자하는 문자는 생략 가능
 * 
 */

SELECT
       EMAIL
  FROM
       EMPLOYEE;

SELECT
       LPAD(EMAIL, 25)
  FROM
       EMPLOYEE;

SELECT
       LPAD(EMAIL, 25, '!')
  FROM
       EMPLOYEE;

SELECT
       EMP_NAME
     , EMP_NO
  FROM 
       EMPLOYEE;

-- EMPLOYEE 테이블에서 모든 직원의 사원명과 주민등록번호 뒤 6자리를 마스킹 처리해서 조회하기
-- 예시 => 이** 621335-1******* 
SELECT 
       RPAD(SUBSTR(EMP_NAME,1,1),4,'*')
     , RPAD(SUBSTR(EMP_NO,1,8),14,'*')
  FROM 
       EMPLOYEE;
------------------------------------------------------------------------------------
/*
 * LTRIM / RTRIM
 * 
 * - LTRIM / RTRIM(STR, 제거하고자 하는 문자)
 * : 문자열의 왼쪽 또는 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
 * 
 * 결과값은 CHARACTER타입으로 반환
 */

SELECT
       LTRIM('        K   H')
  FROM
       DUAL; 
       
SELECT      
       LTRIM('123123KH123','123')
  FROM
   	   DUAL;
----------------------------------------------------------------------------------
/*
 * TRIM
 * 
 * - TRIM(BOTH / LEADING / TRAILRING ' 제거하고자하는 문자 ' FROM STR)
 * : 문자열의 앞/ 뒤/ 양쪽에 있는 문자를 제거한 나머지 문자열을 반환
 * 
 * 결과값은 CHARACTER
 * 기본값은 LEADING/ TRAILRING / BOTH 생략 시 기본값은 BOTH
 * 
 */
SELECT 
       TRIM('     K   H      ')
  FROM
       DUAL; -- BOTH

SELECT
       TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL;

SELECT
       TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL;

------------------------------------------------------------------------------
/*
 * LOWER/ UPPER / INITCAP
 * - LOWER(STR)
 * : 다 소문자로
 * 
 * - UPPER(STR)
 * : 다 대문자로
 * 
 * - INITCAP(STR)
 * : 각 단어마다 앞글자만 대문자로 변경
 * 
 * 결과값은 모두 CHARACTER타입으로 반환
 * 
 * 
 */

SELECT 
       LOWER('HELLO WORLD')
  FROM 
       DUAL;

SELECT
       UPPER('hello world')
  FROM
       DUAL;

SELECT
       INITCAP('hello world')
  FROM
       DUAL;

-------------------------------------------

/*
 * CONCAT
 * 
 * -CONCAT(STR1,STR2)
 * : 전달된 두 개의 인자를 하나로 합친 결과를 반환
 * 
 * 반환타입은 CHARACTER
 * 
 * 
 */

SELECT CONCAT('경실련 하이텔', '정보교육원') FROM DUAL;
----------------------------------------------------------------
/*
 * REPLACE
 * 
 * - REPLACE(STR, 찾을문자, 바꿀문자)
 * : STR로부터 찾을 문자를 찾아서 바꿀 문자로 바꾼 문자열을 반환.
 * 결과값은 CHARACTER
 * 
 */

SELECT 
       REPLACE('서울시 중구 남대문로 120 대일빌딩','대일빌딩','그레이츠 청계')
  FROM
       DUAL;

SELECT 
       EMAIL
     , REPLACE(EMAIL, 'kh.or.kr', 'iei.co.kr')   
  FROM
       EMPLOYEE;

---------------------------------------------------------------------
/*
 * MOD
 * 
 * - MOD(NUMBER1, NUMBER2) : 두 수를 나눈 나머지값을 반환
 * 
 */

SELECT
       MOD(10,3)
     , MOD(-10,3)
     , MOD(10.8,3)
  FROM
       DUAL;

-------------------------------------------------------------------

/*
 * ROUND
 * 
 * - ROUND(NUMBER, 위치) : 반올림 처리해주는 함수 
 * 
 * 위치 : 소수점 아래 N번째 위치를 지정할 수 있음
 * 생략도 가능, 생략시 기본값은 0
 * 
 */

SELECT
       ROUND(123.456)
     , ROUND(123.456,1)
     , ROUND(123.456,2)
     , ROUND(123.456,-1)
     , ROUND(123.456,-2)
  FROM
       DUAL;
-------------------------------------------------------------------
/*
 * FLOOR
 * 
 * - FLOOR(NUMBER) 소수점 아래의 수를 무조건 버림처리해주는 함수
 * 
 * CEIL
 * 
 * -CEIL(NUMBER) 소수점 아래의 수를 무조건 올림처리해주는 함수
 * 
 */
SELECT
       FLOOR(123.45*10)/10
  FROM
       DUAL;

SELECT
       CEIL(123.456)
  FROM
       DUAL;

-- 각 직원별로 고용일로부터 오늘까지의 근무 일수 조회 + 이름조회

SELECT 
       EMP_NAME
     , CONCAT(FLOOR(SYSDATE - HIRE_DATE),'일') "근무일자"
  FROM
       EMPLOYEE
 WHERE
       FLOOR(SYSDATE-HIRE_DATE) > 365*17;

---------------------------------------------------------------------------
/*
 * TRUNC
 * - TRUNC(NUMBER, 위치) : 위치지정이 가능한 절삭처리 함수
 * 
 */

SELECT  
       TRUNC(123.456,2)
  FROM
       DUAL;
---------------------------------------------------------------------------

/*
 * < 날짜 관련 함수 >
 * 
 * DATE 타입 : 년, 월, 일, 시, 분 추로르 모두 포함한 자료형
 * TIMESTAMP <- 얘는 나중에
 * 
 */

SELECT 
       SYSDATE
     , SYSTIMESTAMP 
  FROM 
       DUAL;

-- MONTHS_BETWWEN(DATE1, DATE2) : 두 날짜사이의 개월 수 반환(NUMBER)
-- EMPLOYEE테이블로부터 각 사원 사원명, 고용일로부터 근무일수, 근무개월 수 조회
SELECT
       EMP_NAME
     , FLOOR(SYSDATE - HIRE_DATE) || '일' AS "근무일수"
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "개월수"
  FROM
       EMPLOYEE;

-- ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월 수를 더한 날짜(DATE로 반환)


SELECT
       ADD_MONTHS(SYSDATE, 4)
  FROM
       DUAL;






