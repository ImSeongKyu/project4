package dev.mvc.reply;



//CREATE TABLE reply(
//        REPLYNO                             NUMBER(10)       NOT NULL        PRIMARY KEY,
//        OVERCONTENTSNO                      NUMBER(10)       NOT NULL,
//        THEMEMBERNO                         NUMBER(10)       NOT NULL,
//        REPLYWORD                           CLOB             NULL ,
//        CHU                                 NUMBER(3)        NOT NULL,
//  FOREIGN KEY (OVERCONTENTSNO) REFERENCES OVERCONTENTS (OVERCONTENTSNO),
//  FOREIGN KEY (THEMEMBERNO) REFERENCES THEMEMBER (THEMEMBERNO)
//);
public class ReplyVO {
    //댓글 번호
    private int replyno;
    //컨텐츠 번호
    private int overcontentsno;
    //회원 번호
    private int thememberno;
    //댓글
    private String replyword = "";
    //추천
    private int chu = 0;
    //날짜
    private String rdate="";
    public int getReplyno() {
        return replyno;
    }
    public void setReplyno(int replyno) {
        this.replyno = replyno;
    }
    public int getOvercontentsno() {
        return overcontentsno;
    }
    public void setOvercontentsno(int overcontentsno) {
        this.overcontentsno = overcontentsno;
    }
    public int getThememberno() {
        return thememberno;
    }
    public void setThememberno(int thememberno) {
        this.thememberno = thememberno;
    }
    public String getReplyword() {
        return replyword;
    }
    public void setReplyword(String replyword) {
        this.replyword = replyword;
    }
    public int getChu() {
        return chu;
    }
    public void setChu(int chu) {
        this.chu = chu;
    }
    
    public String getRdate() {
        return rdate;
    }
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    
}
