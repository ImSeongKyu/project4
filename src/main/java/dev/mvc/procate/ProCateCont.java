package dev.mvc.procate;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.msadmin.MsAdminProcInter;
import dev.mvc.overcontents.OverContents;
import dev.mvc.overcontents.OverContentsProcInter;
import dev.mvc.overcontents.OverContentsVO;
import dev.mvc.tool.Tool;


@Controller
public class ProCateCont {
    @Autowired
    @Qualifier("dev.mvc.procate.ProCateProc")
    private ProCateProcInter procateProc;
    
    @Autowired
    @Qualifier("dev.mvc.msadmin.MsAdminProc") // "dev.mvc.admin.AdminProc"라고 명명된 클래스
    private MsAdminProcInter msadminProc; // AdminProcInter를 구현한 AdminProc 클래스의 객체를 자동으로 생성하여 할당
      
    @Autowired
    @Qualifier("dev.mvc.overcontents.OverContentsProc") // @Component("dev.mvc.contents.ContentsProc")
    private OverContentsProcInter overcontentsProc;
    
    public ProCateCont() {
        System.out.println("proCateCont Created");
    }
    
    //FORM 출력
    @RequestMapping(value="/cate/cate_create.do", method=RequestMethod.GET)   //단순히 데이터를 가져오면 GET
    public ModelAndView cate_create() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/cate/cate_create");    //WEB-INF/views/procate/cate_create.jsp
        return mav;
    }
  
  //FORM 데이터 처리
    @RequestMapping(value="/cate/cate_create.do", method=RequestMethod.POST)   //데이터를 처리할 땐 POST
    public ModelAndView cate_create(ProCateVO procateVO) {//자동으로 cateVO 객체가 생성되고 폼의 값이 할당됨.
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.procateProc.cate_create(procateVO);
        System.out.println("-> cnt: " + cnt);
        
        if(cnt == 1) {
            mav.setViewName("redirect:/cate/cate_list.do"); // 주소 자동 이동
            //mav.addObject("code", "cate_create_success");
        }else {
            mav.addObject("code", "cate_create_fail");
            mav.setViewName("/cate/cate_msg");    //WEB-INF/views/procate/cate_msg.jsp 로 이동
        }
        mav.addObject("cnt",cnt);
        return mav;
    }
    
    //localhost:9091/cate/cate_list.do
    /**
     * 전체 목록
     * http://localhost:9091/procate/cate_list.do
     * @return
     */
    @RequestMapping(value="/cate/cate_list.do", method=RequestMethod.GET)   
    public ModelAndView cate_list(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        
        if (this.msadminProc.ms_isAdmin(session) == true) {
            mav.setViewName("/cate/cate_list"); // /WEB-INF/views/cate/cate_list.jsp
            
            ArrayList<ProCateVO> list = this.procateProc.cate_list();
            mav.addObject("list", list);
            ArrayList<Integer> over_count_by_cateno = new ArrayList<Integer>();
            for(int i = 0; i<list.size(); i++) {
                // 특정 카테고리에 속한 레코드 갯수를 리턴
                //int over_count_by_cateno = this.overcontentsProc.over_count_by_cateno(list.get(i).getCatenum());
                over_count_by_cateno.add(this.overcontentsProc.over_count_by_cateno(list.get(i).getCatenum()));
            }
            mav.addObject("over_count_by_cateno", over_count_by_cateno);
            

            
          } else {
            mav.setViewName("/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
            
          }
        
        
        return mav;
    }
    /**
     * 조회
     * http://localhost:9092/cate/cate_read.do?catenum=1
     * @return
     */
    @RequestMapping(value="/cate/cate_read.do", method=RequestMethod.GET) 
    public ModelAndView cate_read(int catenum) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/cate/cate_read");
        ProCateVO procateVO = this.procateProc.cate_read(catenum);
        mav.addObject("procateVO", procateVO);
        return mav;
    }
    
    
    /**
     * 수정
     * @param cateno
     * @return
     */
    @RequestMapping(value="/cate/cate_update.do", method=RequestMethod.GET) 
    public ModelAndView cate_update(HttpSession session, int catenum) {
        ModelAndView mav = new ModelAndView();
        
        if (this.msadminProc.ms_isAdmin(session) == true) {
            // mav.setViewName("/cate/update"); // /WEB-INF/views/cate/update.jsp
            mav.setViewName("/cate/cate_list_update"); // /WEB-INF/views/cate/cate_list_update.jsp
            
            ProCateVO procateVO = this.procateProc.cate_read(catenum);
            mav.addObject("procateVO", procateVO);
            
            ArrayList<ProCateVO> list = this.procateProc.cate_list();
            mav.addObject("list", list);
            
          } else {
            mav.setViewName("/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
            
          }
        
        return mav;
    }
    
    //update 처리
    /**
     * 수정 처리
     * @param cateVO 수정할 내용
     * @return 수정된 레코드 개수
     */
    @RequestMapping(value="/cate/cate_update.do", method=RequestMethod.POST)   //CateVO같은 객체를 가져올 땐 POST
    public ModelAndView cate_update(ProCateVO procateVO) {//자동으로 cateVO 객체가 생성되고 폼의 값이 할당됨.
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.procateProc.cate_update(procateVO);
        System.out.println("-> cnt: " + cnt);
        
        if(cnt == 1) {
            mav.setViewName("redirect:/cate/cate_list.do"); 
  
        }else {
            mav.addObject("code", "cate_update_fail");
            mav.setViewName("/cate/cate_msg"); // /WEB-INF/views/cate/cate_msg.jsp
        }
        
        mav.addObject("cnt",cnt);  // request.setAttribute("cnt", cnt);
        return mav;
    }
    
    /**
     * 삭제폼
     * http://localhost:9091/cate/delete.do
     * @param cateVO 수정할 내용
     * @return 수정된 레코드 갯수
     */
    @RequestMapping(value="/cate/cate_delete.do",method = RequestMethod.GET)
    public ModelAndView cate_delete(HttpSession session, int catenum) {  // int cateno = (int)request.getParameter("cateno"); 이걸 spring이 자동으로 해준다.
      ModelAndView mav = new ModelAndView();
      
      if (this.msadminProc.ms_isAdmin(session) == true) {
          // mav.setViewName("/cate/delete"); // /WEB-INF/views/cate/delete.jsp
          mav.setViewName("/cate/cate_list_delete"); // /WEB-INF/views/cate/list_all_delete.jsp
          
          ProCateVO procateVO = this.procateProc.cate_read(catenum);
          mav.addObject("procateVO", procateVO);
          
          ArrayList<ProCateVO> list = this.procateProc.cate_list();
          mav.addObject("list", list);
          
          // 특정 카테고리에 속한 레코드 갯수를 리턴
          int over_count_by_cateno = this.overcontentsProc.over_count_by_cateno(catenum);
          mav.addObject("over_count_by_cateno", over_count_by_cateno);
          
        } else {
          mav.setViewName("/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
       
        }
      return mav;
    }
    

    // 삭제 처리, 수정 처리를 복사하여 개발
    // 자식 테이블 레코드 삭제 -> 부모 테이블 레코드 삭제
    /**
     * 카테고리 삭제
     * @param session
     * @param cateno 삭제할 카테고리 번호
     * @return
     */
    @RequestMapping(value="/cate/cate_delete.do", method=RequestMethod.POST)
    public ModelAndView cate_delete_proc(HttpSession session, int catenum) { // <form> 태그의 값이 자동으로 저장됨
      
      ModelAndView mav = new ModelAndView();
      
      if (this.msadminProc.ms_isAdmin(session) == true) {
        ArrayList<OverContentsVO> list = this.overcontentsProc.over_list_by_cateno(catenum); // 자식 레코드 목록 읽기
        
        for(OverContentsVO overcontentsVO : list) { // 자식 레코드 관련 파일 삭제
          // -------------------------------------------------------------------
          // 파일 삭제 시작
          // -------------------------------------------------------------------
          String file1saved = overcontentsVO.getFile1saved();
          String thumb1 = overcontentsVO.getThumb1();
          
          String uploadDir = OverContents.getUploadDir();
          Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
          Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
          // -------------------------------------------------------------------
          // 파일 삭제 종료
          // -------------------------------------------------------------------
        }
        
        this.overcontentsProc.over_delete_by_cateno(catenum); // 자식 레코드 삭제     
              
        int cnt = this.procateProc.cate_delete(catenum); // 카테고리 삭제
        
        if (cnt == 1) {
          mav.setViewName("redirect:/cate/cate_list.do");       // 자동 주소 이동, Spring 재호출
          
        } else {
          mav.addObject("code", "delete_fail");
          mav.setViewName("/cate/cate_msg"); // /WEB-INF/views/cate/msg.jsp
        }
        
        mav.addObject("cnt", cnt);
        
      } else {
        mav.setViewName("/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
      }
      
      return mav;
    }
    
    /**
     * 우선 순위 높임, 10 등 -> 1 등, http://localhost:9091/cate/update_seqno_forward.do?cateno=1
     * @param cateVO 수정할 내용
     * @return
     */
    @RequestMapping(value="/cate/cate_update_seqno_forward.do", method = RequestMethod.GET)
    public ModelAndView cate_update_seqno_forward(int catenum) {
      ModelAndView mav = new ModelAndView();
      
      int cnt = this.procateProc.cate_update_seqno_forward(catenum);
      System.out.println("-> cnt: " + cnt);
      
      if (cnt == 1) {
        mav.setViewName("redirect:/cate/cate_list.do"); 
        
      } else {
        mav.addObject("code", "cate_update_fail");
        mav.setViewName("/cate/cate_msg"); // /WEB-INF/views/cate/msg.jsp
      }
      
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//      mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
      
      return mav;
    }
    
    /**
     * 우선 순위 낮춤, 1 등 -> 10 등, http://localhost:9091/cate/update_seqno_backward.do?cateno=1
     * @param cateno 수정할 레코드 PK 번호
     * @return
     */
    @RequestMapping(value="/cate/cate_update_seqno_backward.do", method = RequestMethod.GET)
    public ModelAndView cate_update_seqno_backward(int catenum) {
      ModelAndView mav = new ModelAndView();
      
      int cnt = this.procateProc.cate_update_seqno_backward(catenum);
      System.out.println("-> cnt: " + cnt);
      
      if (cnt == 1) {
        mav.setViewName("redirect:/cate/cate_list.do"); 
        
      } else {
        mav.addObject("code", "cate_update_fail");
        mav.setViewName("/cate/cate_msg"); // /WEB-INF/views/cate/msg.jsp
      }
      
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//      mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
      
      return mav;
    }
    
    /**
     * 카테고리 공개 설정, http://localhost:9091/cate/update_visible_y.do?cateno=1
     * @param cateno 수정할 레코드 PK 번호
     * @return
     */
    @RequestMapping(value="/cate/cate_update_visible_y.do", method = RequestMethod.GET)
    public ModelAndView cate_update_visible_y(int catenum) { 
      ModelAndView mav = new ModelAndView();
      
      int cnt = this.procateProc.cate_update_visible_y(catenum);
      System.out.println("-> cnt: " + cnt);
      
      if (cnt == 1) {
        mav.setViewName("redirect:/cate/cate_list.do"); 
        
      } else {
        mav.addObject("code", "cate_update_fail");
        mav.setViewName("/cate/cate_msg"); // /WEB-INF/views/cate/msg.jsp
      }
      
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//      mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
      
      return mav;
    }
    
    /**
     * 카테고리 비공개 설정, http://localhost:9091/cate/update_visible_n.do?cateno=1
     * @param cateno 수정할 레코드 PK 번호
     * @return
     */
    @RequestMapping(value="/cate/cate_update_visible_n.do", method = RequestMethod.GET)
    public ModelAndView cate_update_visible_n(int catenum) { 
      ModelAndView mav = new ModelAndView();
      
      int cnt = this.procateProc.cate_update_visible_n(catenum);
      System.out.println("-> cnt: " + cnt);
      
      if (cnt == 1) {
        mav.setViewName("redirect:/cate/cate_list.do"); 
        
      } else {
        mav.addObject("code", "cate_update_fail");
        mav.setViewName("/cate/cate_msg"); // /WEB-INF/views/cate/msg.jsp
      }
      
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//      mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
      
      return mav;
    }
    
    
}
