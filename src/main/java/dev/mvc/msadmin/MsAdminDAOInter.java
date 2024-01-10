package dev.mvc.msadmin;

public interface MsAdminDAOInter {
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
     * 회원 정보 조회
     * @param admino
     * @return
     */
    public MsAdminVO ms_read(int msadmino);
}
