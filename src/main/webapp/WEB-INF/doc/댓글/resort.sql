
/**********************************/
/* Table Name: 댓글 */
/**********************************/
DROP TABLE reply CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
DROP TABLE reply;

CREATE TABLE reply(
		REPLYNO                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		OVERCONTENTSNO                		NUMBER(10)		 NOT NULL,
		THEMEMBERNO                   		NUMBER(10)		 NOT NULL,
		REPLYWORD                     		CLOB        	 NULL ,
        CHU                   		        NUMBER(3)		 NOT NULL,
        RDATE                               DATE               NOT NULL,
  FOREIGN KEY (OVERCONTENTSNO) REFERENCES OVERCONTENTS (OVERCONTENTSNO),
  FOREIGN KEY (THEMEMBERNO) REFERENCES THEMEMBER (THEMEMBERNO)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.REPLYNO is '댓글 번호';
COMMENT ON COLUMN reply.OVERCONTENTSNO is '컨텐츠 번호';
COMMENT ON COLUMN reply.THEMEMBERNO is '회원 번호';
COMMENT ON COLUMN reply.REPLYWORD is '댓글';
COMMENT ON COLUMN reply.CHU is '추천';
COMMENT ON COLUMN reply.RDATE is '날짜';


DROP SEQUENCE reply_seq;

CREATE SEQUENCE reply_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지


INSERT INTO reply(REPLYNO, OVERCONTENTSNO, THEMEMBERNO, REPLYWORD, CHU, RDATE)
VALUES(reply_seq.nextval, 34, 3, '임시 댓글', 0, sysdate);


SELECT *
FROM reply
ORDER BY REPLYNO DESC;

COMMIT;