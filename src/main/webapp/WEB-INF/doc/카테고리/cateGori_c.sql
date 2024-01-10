/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE procate;


CREATE TABLE procate(
		catenum                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(50)		 NOT NULL,
		cnt                           		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
        seqno                               NUMBER(5)   DEFAULT 1       NOT NULL,
        visible                             CHAR(1)     DEFAULT 'N'         NOT NULL

);

COMMENT ON TABLE procate is '카테고리';
COMMENT ON COLUMN procate.catenum is '카테고리번호';
COMMENT ON COLUMN procate.name is '카테고리이름';
COMMENT ON COLUMN procate.cnt is '관련 자료수';
COMMENT ON COLUMN procate.rdate is '등록일';
COMMENT ON COLUMN procate.seqno is '출력 순서';
COMMENT ON COLUMN procate.visible is '출력 모드';
COMMENT ON COLUMN procate.explain is '카테고리 설명';

DROP SEQUENCE autocate_seq;
CREATE SEQUENCE autocate_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999999
    CACHE 2
    NOCYCLE;
    
INSERT INTO procate(catenum, seqno, name, cnt, rdate) VALUES(autocate_seq.nextval, autocate_seq.nextval, '젠장', 0, sysdate);
SELECT * FROM procate;

ALTER TABLE procate ADD explain CLOB NULL;

ROLLBACK;
COMMIT;

