package dev.mvc.themember;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;  // 구현 클래스를 교체하기 쉬운 구조 지원

import javax.servlet.http.HttpSession;

public interface TheMemberProcInter {

    /**
     * 중복 아이디 검사
     * @param id
     * @return 중복 아이디 갯수
     */
    public int the_checkID(String id);

    /**
     * 회원 가입
     * @param thememberVO
     * @return 추가한 레코드 갯수
     */
    public int the_create(TheMemberVO thememberVO);

    /**
     * 회원 전체 목록
     * @return
     */
    public ArrayList<TheMemberVO> the_list();

    /**
     * thememberno로 회원 정보 조회
     * @param thememberno
     * @return
     */
    public TheMemberVO the_read(int thememberno);
    
    /**
     * id로 회원 정보 조회
     * @param id
     * @return
     */
    public TheMemberVO the_readById(String id);
    /**
     * 로그인된 회원 계정인지 검사합니다.
     * @param session
     * @return true: 사용자
     */
    public boolean isMember(HttpSession session);

    /**
     * 로그인된 관리자 계정인지 검사합니다.
     * @param session
     * @return true: 사용자
     */
    public boolean isMemberAdmin(HttpSession session);
    /**
     * 수정 처리
     * @param thememberVO
     * @return
     */
    public int the_update(TheMemberVO thememberVO);
    /**
     * 회원 삭제 처리
     * @param memberno
     * @return
     */
    public int the_delete(int thememberno);
    /**
     * 현재 패스워드 검사
     * @param map
     * @return 0: 일치하지 않음, 1: 일치함
     */
    public int the_passwd_check(HashMap<String, Object> map);
    
    /**
     * 패스워드 변경
     * @param map
     * @return 변경된 패스워드 갯수
     */
    public int the_passwd_update(HashMap<String, Object> map);
    
    /**
     * 로그인 처리
     */
    public int login(HashMap<String, Object> map);
}
