package dev.mvc.reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.reply.ReplyProc")//해당 클래스 ContentProc의 이름을 지정
public class ReplyProc implements ReplyProcInter{

    @Autowired//ContentsDAOInter interface를 구현한 클래스의 객체를 만들어 자동 할당
    private ReplyDAOInter replyDAO;
    
    @Override
    public int reply_create(ReplyVO replyVO) {
        int cnt = this.replyDAO.reply_create(replyVO);
        return cnt;
    }

    @Override
    public ReplyVO reply_all(int overcontentsno) {
        ReplyVO replyVO = this.replyDAO.reply_all(overcontentsno);
        return replyVO;
    }

    @Override
    public int reply_cnt_yes(int overcontentsno, int thememberno) {
        int cnt = this.replyDAO.reply_cnt_yes(overcontentsno, thememberno);
        return cnt;
    }

    @Override
    public int reply_cnt_no(int overcontentsno, int thememberno) {
        int cnt = this.replyDAO.reply_cnt_no(overcontentsno, thememberno);
        return cnt;
    }

}
