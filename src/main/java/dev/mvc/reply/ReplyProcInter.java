package dev.mvc.reply;

public interface ReplyProcInter {
    /**
     * 등록
     * @param contentsVO
     * @return
     */
    public int reply_create(ReplyVO replyVO);
    
    /**
     * 조회
     * @param overcontentsno
     * @return
     */
    public ReplyVO reply_all(int overcontentsno);
    
    /**
     * 추천 유
     * @param overcontentsno
     * @param thememberno
     * @return 
     */
    public int reply_cnt_yes(int overcontentsno, int thememberno);
    /**
     * 추천 무
     * @param overcontentsno
     * @param thememberno
     * @return 
     */
    public int reply_cnt_no(int overcontentsno, int thememberno);
}
