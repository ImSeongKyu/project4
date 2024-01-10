package dev.mvc.msadmin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.msadmin.MsAdminProc")
public class MsAdminProc implements MsAdminProcInter {
    @Autowired
    private MsAdminDAOInter msadminDAO;

    @Override
    public int ms_login(MsAdminVO msadminVO) {
        int cnt = this.msadminDAO.ms_login(msadminVO);
        return cnt;
    }

    @Override
    public MsAdminVO ms_read_by_id(String id) {
        MsAdminVO msadminVO = this.msadminDAO.ms_read_by_id(id);
        return msadminVO;
    }

    @Override
    public boolean ms_isAdmin(HttpSession session) {
        boolean msadmin = false;
        
        if (session != null) {
          String msadmin_id = (String)session.getAttribute("admin_id");
          
          if (msadmin_id != null) {
            msadmin = true;
          }
        }
        
        return msadmin;
    }

    @Override
    public MsAdminVO ms_read(int msadmino) {
        MsAdminVO msadminVO = this.msadminDAO.ms_read(msadmino);
        return msadminVO;
    }

}
