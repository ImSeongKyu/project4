package dev.mvc.overcontents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * 개발자가 구현합니다.
 * @author imseongkyu
 *
 */
public interface OverContentsProcInter {
    /**
     * 등록
     * @param contentsVO
     * @return
     */
    public int over_create(OverContentsVO overcontentsVO);
    /**
     * 유형1선택
     * @return
     */
    public ArrayList<OverContentsVO> over_list_all();

    /**
     * 카테고리별 등록된 글 목록
     * @param catenum
     * @return
     */
    public ArrayList<OverContentsVO> over_list_by_cateno(int catenum);
    
    /**
     * 조회
     * @param overcontentsno
     * @return
     */
    public OverContentsVO over_read(int overcontentsno);
    
    /**
     * map 등록, 수정, 삭제
     * @param map
     * @return 수정된 레코드 갯수
     */
    public int map(HashMap<String, Object> map);

    /**
     * youtube 등록, 수정, 삭제
     * @param youtube
     * @return 수정된 레코드 갯수
     */
    public int youtube(HashMap<String, Object> map);
    
    /**
     * 카테고리별 검색 목록
     * @param map
     * @return
     */
    public ArrayList<OverContentsVO> over_list_by_cateno_search(HashMap<String, Object> hashMap );
    
    /**
     * 카테고리별 검색 레코드 개수
     * @param map
     * @return
     */
    public int over_search_count(HashMap<String, Object> hashMap);
    
    /**
     * 카테고리별 검색 + 페이징 목록
     * @param contentsVO
     * @return
     */
    public ArrayList<OverContentsVO> over_list_by_cateno_search_paging(OverContentsVO overcontentsVO);
    
    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param catenum          카테고리번호 
     * @param now_page      현재 페이지
     * @param word 검색어
     * @param list_file 목록 파일명 
     * @param search_count 검색 레코드수   
     * @return 페이징 생성 문자열
     */ 
    public String pagingBox(int catenum, int now_page, String word, String list_file, int search_count);
    
    /**
     * 패스워드 검사
     * @param hashMap
     * @return
     */
    public int over_password_check(HashMap<String, Object> hashMap);
    
    /**
     * 글 정보 수정
     * @param overcontentsVO
     * @return 처리된 레코드 갯수
     */
    public int over_update_text(OverContentsVO overcontentsVO);

    /**
     * 파일 정보 수정
     * @param overcontentsVO
     * @return 처리된 레코드 갯수
     */
    public int over_update_file(OverContentsVO overcontentsVO);
    
    /**
     * 삭제
     * @param overcontentsno
     * @return 삭제된 레코드 갯수
     */
    public int over_delete(int overcontentsno);
    
    /**
     * FK cateno 값이 같은 레코드 갯수 산출
     * @param catenum
     * @return
     */
    public int over_count_by_cateno(int catenum);
   
    /**
     * 특정 카테고리에 속한 모든 레코드 삭제
     * @param catenum
     * @return 삭제된 레코드 갯수
     */
    public int over_delete_by_cateno(int catenum);
    
    /**
     * 조회수 증가
     * @param overcontentsno
     * @return 
     */
    public int over_cnt_up(int overcontentsno);
}
