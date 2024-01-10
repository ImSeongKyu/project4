package dev.mvc.themember;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.themember.TheMemberProc")
public class TheMemberProc implements TheMemberProcInter {
    @Autowired
    private TheMemberDAOInter thememberDAO;
    
    public TheMemberProc() {
        //System.out.println("-> TheMemberProc created.");
    }
    
    @Override
    public int the_checkID(String id) {
      int cnt = this.thememberDAO.the_checkID(id);
      return cnt;
    }

    @Override
    public int the_create(TheMemberVO thememberVO) {
        int cnt = this.thememberDAO.the_create(thememberVO);
        return cnt;
    }

    @Override
    public ArrayList<TheMemberVO> the_list() {
        ArrayList<TheMemberVO> list = this.thememberDAO.the_list();
        return list;
    }

    @Override
    public TheMemberVO the_read(int thememberno) {
        TheMemberVO thememberVO = this.thememberDAO.the_read(thememberno);
        return thememberVO;
    }

    @Override
    public TheMemberVO the_readById(String id) {
        TheMemberVO thememberVO = this.thememberDAO.the_readById(id);
        return thememberVO;
    }

    @Override
    public boolean isMember(HttpSession session) {
        boolean sw = false; // 로그인하지 않은 것으로 초기화
        int grade = 99;
        
        // System.out.println("-> grade: " + session.getAttribute("grade"));
        if (session != null) {
          String id = (String)session.getAttribute("id");
          if (session.getAttribute("grade") != null) {
            grade = (int)session.getAttribute("grade");
          }
          
          if (id != null && grade <= 20){ // 관리자 + 회원
            sw = true;  // 로그인 한 경우
          }
        }
        
        return sw;
    }

    @Override
    public boolean isMemberAdmin(HttpSession session) {
        boolean sw = false; // 로그인하지 않은 것으로 초기화
        int grade = 99;
        
        // System.out.println("-> grade: " + session.getAttribute("grade"));
        if (session != null) {
          String id = (String)session.getAttribute("id");
          if (session.getAttribute("grade") != null) {
            grade = (int)session.getAttribute("grade");
          }
          
          if (id != null && grade <= 10){ // 관리자 
            sw = true;  // 로그인 한 경우
          }
        }
        
        return sw;
    }

    @Override
    public int the_update(TheMemberVO thememberVO) {
        int cnt = this.thememberDAO.the_update(thememberVO);
        return cnt;
    }

    @Override
    public int the_delete(int thememberno) {
        int cnt = this.thememberDAO.the_delete(thememberno);
        return cnt;
    }

    @Override
    public int the_passwd_check(HashMap<String, Object> map) {
        int cnt = this.thememberDAO.the_passwd_check(map);
        return cnt;
    }

    @Override
    public int the_passwd_update(HashMap<String, Object> map) {
        int cnt = this.thememberDAO.the_passwd_update(map);
        return cnt;
    }

    @Override
    public int login(HashMap<String, Object> map) {
        int cnt = this.thememberDAO.login(map);
        return cnt;
    }
    
}
