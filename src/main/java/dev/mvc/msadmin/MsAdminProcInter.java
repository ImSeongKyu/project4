package dev.mvc.msadmin;

import javax.servlet.http.HttpSession;

public interface MsAdminProcInter {
    /**
     * 로그인
     * @param AdminVO
     * @return
     */
    public int ms_login(MsAdminVO msadminVO);
    
    /**
     * 회원 정보
     * @param String
     * @return
     */
    public MsAdminVO ms_read_by_id(String id);
    
    /**
     * 관리자 로그인 체크
     * @param session
     * @return
     */
    public boolean ms_isAdmin(HttpSession session);
    
    /**
     * 회원 정보 조회
     * @param admino
     * @return
     */
    public MsAdminVO ms_read(int msadmino);
}
