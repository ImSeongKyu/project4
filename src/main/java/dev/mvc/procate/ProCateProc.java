package dev.mvc.procate;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//Controller가 사용하는 이름
//Controller는 @Qualifier 선언을 통해 사용 가능
@Component("dev.mvc.procate.ProCateProc")
public class ProCateProc implements ProCateProcInter {
    
    @Autowired
    private ProCateDAOInter procateDAO;
    
    
    @Override
    public int cate_create(ProCateVO procateVO) {
        int cnt = this.procateDAO.cate_create(procateVO);
        return cnt;
    }
    @Override
    public ArrayList<ProCateVO> cate_list(){
        ArrayList<ProCateVO> list = this.procateDAO.cate_list();
        return list;
    }
    @Override
    public ProCateVO cate_read(int catenum) {
        ProCateVO procateVO = this.procateDAO.cate_read(catenum);
        return procateVO;
    }
    @Override
    public int cate_update(ProCateVO procateVO) {
        int cnt = this.procateDAO.cate_update(procateVO);
        return cnt;
    }
    @Override
    public int cate_delete(int catenum) {
        int cnt = this.procateDAO.cate_delete(catenum);
        return cnt;
    }
    @Override
    public int cate_update_seqno_forward(int catenum) {
        int cnt = this.procateDAO.cate_update_seqno_forward(catenum);
        return cnt;
    }
    @Override
    public int cate_update_seqno_backward(int catenum) {
        int cnt = this.procateDAO.cate_update_seqno_backward(catenum);
        return cnt;
    }
    @Override
    public int cate_update_visible_y(int catenum) {
        int cnt = this.procateDAO.cate_update_visible_y(catenum);
        return cnt;
    }
    @Override
    public int cate_update_visible_n(int catenum) {
        int cnt = this.procateDAO.cate_update_visible_n(catenum);
        return cnt;
    }
    @Override
    public ArrayList<ProCateVO> cate_list_all_y() {
        ArrayList<ProCateVO> list = this.procateDAO.cate_list_all_y();
        return list;
    }
    @Override
    public int cate_update_cnt_up(int catenum) {
        int cnt = this.procateDAO.cate_update_cnt_up(catenum);
        return cnt;
    }
    @Override
    public int cate_update_cnt_down(int catenum) {
        int cnt = this.procateDAO.cate_update_cnt_down(catenum);
        return cnt;
    }

}
