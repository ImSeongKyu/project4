package dev.mvc.project1;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.overcontents.OverContentsProcInter;
import dev.mvc.overcontents.OverContentsVO;
import dev.mvc.procate.ProCateProcInter;
import dev.mvc.procate.ProCateVO;

@Controller
public class HomeCont {
  @Autowired // CateProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
  @Qualifier("dev.mvc.procate.ProCateProc")
  private ProCateProcInter procateProc;
  
  @Autowired // CateProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
  @Qualifier("dev.mvc.overcontents.OverContentsProc")
  private OverContentsProcInter overcontentsProc;
  
  
  public HomeCont() {
    System.out.println("-> project4 HomeCont created.");
  }
  
  // http://localhost:9091
  @RequestMapping(value= {"", "/", "/index.do", "/index.resort"}, method=RequestMethod.GET)
  public ModelAndView home() {
    System.out.println("-> home() ver 4");
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/contents/over_list_all_gallery"); // /WEB-INF/views/index.jsp
    // spring.mvc.view.prefix=/WEB-INF/views/
    // spring.mvc.view.suffix=.jsp
    ArrayList<OverContentsVO> list = this.overcontentsProc.over_list_all();
    mav.addObject("list", list);
        
    return mav;
  }
  
  // http://localhost:9091/menu/top.do
  @RequestMapping(value= {"/menu/top.do"}, method=RequestMethod.GET)
  public ModelAndView top() {
    ModelAndView mav = new ModelAndView();

    ArrayList<ProCateVO> list_top = this.procateProc.cate_list_all_y();
    mav.addObject("list_top", list_top);
    
    mav.setViewName("/menu/top"); // /WEB-INF/views/menu/top.jsp
    
    return mav;
  }
}




