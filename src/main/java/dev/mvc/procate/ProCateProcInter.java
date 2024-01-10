package dev.mvc.procate;

import java.util.ArrayList;

//개발자가 구현하는 인터페이스
//데이터 처리 알고리즘을 주로 구현
public interface ProCateProcInter {
  //기능이 단순하여 데이터 처리 알고리즘이 없을 경우 CateDAOInter 인터페이스의 추상 메소드를 복사함
    public int cate_create(ProCateVO procateVO);
    public ArrayList<ProCateVO> cate_list();
    public ProCateVO cate_read(int catenum);
    public int cate_update(ProCateVO procateVO);
    public int cate_delete(int catenum);
    public int cate_update_seqno_forward(int cateno);
    public int cate_update_seqno_backward(int cateno);
    public int cate_update_visible_y(int cateno);
    public int cate_update_visible_n(int cateno);
    public ArrayList<ProCateVO> cate_list_all_y();
    /**
     * 총량(cnt) 증가  
     * @param catenum
     * @return 수정된 레코드 갯수
     */
    public int cate_update_cnt_up(int catenum);
    /**
     * 총량(cnt) 감소  
     * @param catenum
     * @return 수정된 레코드 갯수
     */
    public int cate_update_cnt_down(int catenum);
}
