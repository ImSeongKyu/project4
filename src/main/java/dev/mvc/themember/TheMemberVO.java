package dev.mvc.themember;

import org.springframework.web.multipart.MultipartFile;

public class TheMemberVO {

    /** 회원 번호 */
    private int thememberno;
    /** 아이디(이메일) */
    private String id = "";
    /** 패스워드 */
    private String passwd = "";
    /** 회원 성명 */
    private String mname = "";
    /** 전화 번호 */
    private String tel = "";
    /** 우편 번호 */
    private String zipcode = "";
    /** 주소 1 */
    private String address1 = "";
    /** 주소 2 */
    private String address2 = "";
    /** 가입일 */
    private String mdate = "";
    /** 등급 */
    private int grade = 0;

    /** 등록된 패스워드 */
    private String old_passwd = "";
    /** id 저장 여부 */
    private String id_save = "";
    /** passwd 저장 여부 */
    private String passwd_save = "";
    /** 이동할 주소 저장 */
    private String url_address = "";
    public int getThememberno() {
        return thememberno;
    }
    public void setThememberno(int thememberno) {
        this.thememberno = thememberno;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPasswd() {
        return passwd;
    }
    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }
    public String getMname() {
        return mname;
    }
    public void setMname(String mname) {
        this.mname = mname;
    }
    public String getTel() {
        return tel;
    }
    public void setTel(String tel) {
        this.tel = tel;
    }
    public String getZipcode() {
        return zipcode;
    }
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }
    public String getAddress1() {
        return address1;
    }
    public void setAddress1(String address1) {
        this.address1 = address1;
    }
    public String getAddress2() {
        return address2;
    }
    public void setAddress2(String address2) {
        this.address2 = address2;
    }
    public String getMdate() {
        return mdate;
    }
    public void setMdate(String mdate) {
        this.mdate = mdate;
    }
    public int getGrade() {
        return grade;
    }
    public void setGrade(int grade) {
        this.grade = grade;
    }
    public String getOld_passwd() {
        return old_passwd;
    }
    public void setOld_passwd(String old_passwd) {
        this.old_passwd = old_passwd;
    }
    public String getId_save() {
        return id_save;
    }
    public void setId_save(String id_save) {
        this.id_save = id_save;
    }
    public String getPasswd_save() {
        return passwd_save;
    }
    public void setPasswd_save(String passwd_save) {
        this.passwd_save = passwd_save;
    }
    public String getUrl_address() {
        return url_address;
    }
    public void setUrl_address(String url_address) {
        this.url_address = url_address;
    }
    
}
