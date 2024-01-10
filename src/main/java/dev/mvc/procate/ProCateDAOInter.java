package dev.mvc.procate;

import java.util.ArrayList;

//procate.xml에서 proCateDAOInter인터페이스와 연결하도록 지시함
//이 때 proCateDAOInter는 procate.xml에 명시된 id = create메소드를 가지고 있어야 한다.
public interface ProCateDAOInter {
    /**
     * 내용 삽입
     * @param procateVO
     * @return
     */
    public int cate_create(ProCateVO procateVO);
    /**
     * 전체 목록 조회
     * @return
     */
    public ArrayList<ProCateVO> cate_list();
    /**
     * 읽기(조회)
     * @param catenum
     * @return
     */
    public ProCateVO cate_read(int catenum);
    /**
     * 수정
     * @param cateVO
     * @return
     */
    public int cate_update(ProCateVO procateVO);
    /**
     * 삭제
     * @param catenum
     * @return
     */
    public int cate_delete(int catenum);
    /**
     * 우선 순위 높임, 10 등 -> 1 등   
     * @param catenum
     * @return 수정된 레코드 갯수
     */
    public int cate_update_seqno_forward(int catenum);

    /**
     * 우선 순위 낮춤, 1 등 -> 10 등   
     * @param catenum
     * @return 수정된 레코드 갯수
     */
    public int cate_update_seqno_backward(int catenum);
    
    /**
     * 카테고리 공개 설정
     * @param catenum
     * @return
     */
    public int cate_update_visible_y(int catenum);
    
    /**
     * 카테고리 비공개 설정
     * @param catenum
     * @return
     */
    public int cate_update_visible_n(int catenum);
    
    /**
     * 비회원/회원 SELECT LIST
     * @return
     */
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
