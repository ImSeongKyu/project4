package dev.mvc.msadmin;

public class MsAdminVO {
    private int msadminno;
    private String id;
    private String passwd;
    private String mname;
    private String mdate;
    private int grade;
    
    public int getMsadminno() {
        return msadminno;
    }
    public void setMsadminno(int msadminno) {
        this.msadminno = msadminno;
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
    @Override
    public String toString() {
        return "MsAdminVO [msadminno=" + msadminno + ", id=" + id + ", passwd=" + passwd + ", mname=" + mname
                + ", mdate=" + mdate + ", grade=" + grade + "]";
    }
    
}
