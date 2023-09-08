CREATE TABLE MEMBER(
    ID VARCHAR2(100) PRIMARY KEY,
    PASSWORD VARCHAR2(150) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    ADDRESS VARCHAR2(200) NOT NULL
);
SELECT * FROM MEMBER;

CREATE SEQUENCE SEQ_BOARD;
CREATE TABLE BOARD(
    NO NUMBER,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(2000) NOT NULL,
    WRITER VARCHAR2(50) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE
);
ALTER TABLE board ADD url VARCHAR(200);

SELECT * FROM BOARD order by no desc;

INSERT INTO board(no, title, content, writer) 
(SELECT SEQ_BOARD.NEXTVAL, title, content, writer FROM board);
COMMIT;

ALTER TABLE board ADD CONSTRAINT PK_BOARD PRIMARY KEY(no);

SELECT * FROM board ORDER BY no DESC;

-- 힌트(인덱스로 정렬하면 좀 더 빠름)
-- 첫페이지
SELECT NUM, NO, TITLE, WRITER, REGDATE
FROM (
    SELECT /*+ INDEX_DESC(board PK_BOARD) */ 
    ROWNUM NUM, NO, TITLE, WRITER, REGDATE
    FROM board
    WHERE ROWNUM<= 10)
WHERE NUM >0;

-- 두번째 페이지(11~20)
SELECT NUM, NO, TITLE, WRITER, REGDATE
FROM (
    SELECT /*+ INDEX_DESC(board PK_BOARD) */ 
    ROWNUM NUM, NO, TITLE, WRITER, REGDATE
    FROM board
    WHERE ROWNUM<= 20)
WHERE NUM >10;

-- 세번째 페이지(21~30)
SELECT NUM, NO, TITLE, WRITER, REGDATE
FROM (
    SELECT /*+ INDEX_DESC(board PK_BOARD) */ 
    ROWNUM NUM, NO, TITLE, WRITER, REGDATE
    FROM board
    WHERE ROWNUM<= 30)
WHERE NUM >20;