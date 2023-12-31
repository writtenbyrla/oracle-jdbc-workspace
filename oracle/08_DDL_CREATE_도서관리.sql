--출판사 테이블 : TB_PUBLISHER
--도서 테이블 : TB_BOOK
--회원 테이블 : TB_MEMBER
--대여 목록 테이블 : TB_RENT

-- 1.
CREATE TABLE TB_PUBLISHER (
    PUB_NO NUMBER PRIMARY KEY,
    PUB_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(50)
--    CONSTRAINT TB_PUBLISHER_PUB_NO_PK PRIMARY KEY(PUB_NO)
);
INSERT INTO TB_PUBLISHER VALUES(1, '인사이트', '02-1111-2222');
INSERT INTO TB_PUBLISHER VALUES(2, '제이펍', '02-3333-4444');
INSERT INTO TB_PUBLISHER VALUES(3, '한빛미디어', '02-5555-6666');

SELECT * FROM TB_PUBLISHER;

-- 2.
CREATE TABLE TB_BOOK(
    BK_NO NUMBER PRIMARY KEY,
    BK_TITLE VARCHAR2(50) NOT NULL,
    BK_AUTHOR VARCHAR2(20) NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER REFERENCES TB_PUBLISHER ON DELETE CASCADE
    -- CONSTRAINT TB_BOOK_BK_NO_PK PRIMARY KEY(BK_NO),
    -- CONSTRAINT TB_BOOK_BK_PUB_NO FOREIGN KEY(BK_PUB_NO) REFERENCES TB_PUBLISHER ON DELETE CASCADE
);
INSERT INTO TB_BOOK VALUES(1, '프로그래머 열정을 말하다', '채드 파울러', 12600, 1);
INSERT INTO TB_BOOK VALUES(2, '1일 1로그 100일 완성 IT 지식', '브라이언', 18000, 1);
INSERT INTO TB_BOOK VALUES(3, '인스파이어드', '마티 케이건', 21600, 2);
INSERT INTO TB_BOOK VALUES(4, '혼자 공부하는 얄팍한 코딩 지식', '고현민', 16200, 3);
INSERT INTO TB_BOOK VALUES(5, '함께 자라기', '김창준', 11700, 1);

SELECT * FROM TB_BOOK;

-- 3. 
DROP TABLE TB_MEMBER;
CREATE TABLE TB_MEMBER (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER VARCHAR(2) CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(50),
    PHONE VARCHAR2(20),
    STATUS VARCHAR(2) DEFAULT 'N' CHECK(STATUS IN ('Y', 'N')),
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL
    -- CONSTRAINT TB_MEMBER_MEMBER_NO_PK PRIMARY KEY(MEMBER_NO)
);
INSERT INTO TB_MEMBER VALUES(1, 'USER1', '1234', '유병재', 'M', '서울시 강남구', '010-1111-2222', 'N', SYSDATE);
INSERT INTO TB_MEMBER VALUES(2, 'USER2', '1234', '김동현', 'M', '서울시 강남구', '010-3333-4444', 'N', SYSDATE);
INSERT INTO TB_MEMBER VALUES(3, 'USER3', '1234', '강호동', 'F', '서울시 강남구', '010-5555-6666', 'N', SYSDATE);

SELECT * FROM TB_MEMBER;

-- 4. 
CREATE TABLE TB_RENT (
    RENT_NO NUMBER PRIMARY KEY,
    RENT_MEM_NO NUMBER REFERENCES TB_MEMBER ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER REFERENCES TB_BOOK ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);
INSERT INTO TB_RENT VALUES(1, 1, 2, SYSDATE);
INSERT INTO TB_RENT VALUES(2, 1, 3, SYSDATE);
INSERT INTO TB_RENT VALUES(3, 2, 1, SYSDATE);
INSERT INTO TB_RENT VALUES(4, 2, 2, SYSDATE);
INSERT INTO TB_RENT VALUES(5, 1, 5, SYSDATE);
SELECT * FROM TB_RENT;

-- 5. 
SELECT MEMBER_NAME, MEMBER_ID, RENT_BOOK_NO, RENT_DATE, RENT_DATE+7
FROM TB_MEMBER TM
JOIN TB_RENT TR ON (TM.MEMBER_NO = TR.RENT_MEM_NO)
WHERE RENT_BOOK_NO = 2;

-- 6. 
SELECT BK_TITLE, PUB_NAME, RENT_DATE, RENT_DATE+7
FROM TB_RENT TR
JOIN TB_BOOK TB ON (TR.RENT_BOOK_NO = TB.BK_NO)
JOIN TB_PUBLISHER TP ON (TB.BK_PUB_NO = TP.PUB_NO)
WHERE TR.RENT_MEM_NO = 1;

