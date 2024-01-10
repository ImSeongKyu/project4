package dev.mvc.overcontents;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.msadmin.MsAdminProcInter;
import dev.mvc.procate.ProCateProcInter;
import dev.mvc.procate.ProCateVO;
import dev.mvc.reply.ReplyProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class OverContentsCont {
    @Autowired
    @Qualifier("dev.mvc.msadmin.MsAdminProc") 
    private MsAdminProcInter msadminProc;
    
    @Autowired
    @Qualifier("dev.mvc.procate.ProCateProc") 
    private ProCateProcInter procateProc;
    
    @Autowired
    @Qualifier("dev.mvc.overcontents.OverContentsProc") // @Component("dev.mvc.contents.ContentsProc")
    private OverContentsProcInter overcontentsProc;
    
    @Autowired
    @Qualifier("dev.mvc.reply.ReplyProc") 
    private ReplyProcInter replyProc;
    
    public OverContentsCont () {
      System.out.println("-> OverContentsCont created.");
    }
    /**
     * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
     * POST → url → GET → 데이터 전송
     * @return
     */
    @RequestMapping(value="/contents/over_msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward
      
      return mav; // forward
    }
    // 등록 폼, contents 테이블은 FK로 cateno를 사용함.
    // http://localhost:9091/contents/create.do  X
    // http://localhost:9091/contents/create.do?cateno=1
    // http://localhost:9091/contents/create.do?cateno=2
    // http://localhost:9091/contents/create.do?cateno=3
    //cateno 변수값을 보내는 목적은?
    //
    @RequestMapping(value="/contents/over_create.do", method = RequestMethod.GET)
    public ModelAndView over_create(int catenum) {
      ModelAndView mav = new ModelAndView();

      ProCateVO procateVO = this.procateProc.cate_read(catenum); // over_create.jsp에 카테고리 정보를 출력하기위한 목적
      //create.jsp에서는 cateVO.name이런식으로 사용할 수 이씀
      mav.addObject("procateVO", procateVO);

      
      mav.setViewName("/contents/over_create"); // /webapp/WEB-INF/views/contents/over_create.jsp
      
      return mav;
    }
    


    /**
     * 등록 처리 http://localhost:9092/contents/over_create.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/over_create.do", method = RequestMethod.POST)
    public ModelAndView over_create(HttpServletRequest request, HttpSession session, OverContentsVO overcontentsVO) {
      ModelAndView mav = new ModelAndView();
      
      if (msadminProc.ms_isAdmin(session)) { // 관리자로 로그인한경우
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 시작
        // ------------------------------------------------------------------------------
        String file1 = "";          // 원본 파일명 image
        String file1saved = "";   // 저장된 파일명, image
        String thumb1 = "";     // preview image

        String upDir =  OverContents.getUploadDir(); // 파일을 업로드할 폴더 준비
        System.out.println("-> upDir: " + upDir);
        
        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF' 
        //           value='' placeholder="파일 선택">
        MultipartFile mf = overcontentsVO.getFile1MF();
        
        file1 = mf.getOriginalFilename(); // 원본 파일명 산출, 01.jpg
        System.out.println("-> 원본 파일명 산출 file1: " + file1);
        
        long size1 = mf.getSize();  // 파일 크기
        
        if (size1 > 0) { // 파일 크기 체크
          // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
          file1saved = Upload.saveFileSpring(mf, upDir); 
          
          if (Tool.isImage(file1saved)) { // 이미지인지 검사
            // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
            thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
          }
          
        }    
        
        overcontentsVO.setFile1(file1);   // 순수 원본 파일명
        overcontentsVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
        overcontentsVO.setThumb1(thumb1);      // 원본이미지 축소판
        overcontentsVO.setSize1(size1);  // 파일 크기
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------
        System.out.println(overcontentsVO.toString());
        // Call By Reference: 메모리 공유, Hashcode 전달
        int adminno = (int)session.getAttribute("adminno"); // adminno FK
        overcontentsVO.setMsadminno(adminno);
        int cnt = this.overcontentsProc.over_create(overcontentsVO); 
        
        // ------------------------------------------------------------------------------
        // PK의 return
        // ------------------------------------------------------------------------------
        // System.out.println("--> contentsno: " + contentsVO.getContentsno());
        // mav.addObject("contentsno", contentsVO.getContentsno()); // redirect parameter 적용
        // ------------------------------------------------------------------------------
        
        if (cnt == 1) {
            mav.addObject("code", "create_success");
            procateProc.cate_update_cnt_up(overcontentsVO.getCatenum()); // 글수 증가
            
            
        } else {
            mav.addObject("code", "create_fail");
        }
        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
        
        // System.out.println("--> cateno: " + contentsVO.getCateno());
        // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
        mav.addObject("catenum", overcontentsVO.getCatenum()); // redirect parameter 적용
        
        mav.addObject("url", "/contents/over_msg"); // msg.jsp, redirect parameter 적용
        mav.setViewName("redirect:/contents/over_msg.do"); // Post -> Get - param...

      } else {
        mav.addObject("url", "/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
        mav.setViewName("redirect:/contents/over_msg.do"); 
      }
      
      return mav; // forward
    }
    
    /**
     * 전체 목록 관리자만 사용가능
     * http://localhost:9091/contents/over_list.do
     * @return
     */
    @RequestMapping(value="/contents/over_list.do", method = RequestMethod.GET)
    public ModelAndView over_list_all(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      if (this.msadminProc.ms_isAdmin(session) == true) {
        mav.setViewName("/contents/over_list"); // /WEB-INF/views/contents/over_list.jsp
        
        ArrayList<OverContentsVO> list = this.overcontentsProc.over_list_all();
        
        // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
        for (OverContentsVO overcontentsVO : list) {
          String title = overcontentsVO.getTitle();
          String content = overcontentsVO.getContent();
          
          title = Tool.convertChar(title);  // 특수 문자 처리
          content = Tool.convertChar(content); 
          
          overcontentsVO.setTitle(title);
          overcontentsVO.setContent(content);  

        }
        mav.addObject("list", list);
        
      } else {
        mav.setViewName("/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
        
      }
      
      return mav;
    }
    

    /**
     * 특정 카테고리의 검색 목록
     * http://localhost:9091/contents/over_list_by_cateno.do?catenum=1
     * @return
     */
//    @RequestMapping(value="/contents/over_list_by_cateno.do", method = RequestMethod.GET)
//    public ModelAndView over_list_by_cateno(int catenum) {
//      ModelAndView mav = new ModelAndView();
//
//      mav.setViewName("/contents/over_list_by_cateno"); // /WEB-INF/views/contents/list_by_cateno.jsp
//      
//      ProCateVO procateVO = this.procateProc.cate_read(catenum); // create.jsp에 카테고리 정보를 출력하기위한 목적
//      mav.addObject("procateVO", procateVO);
      // request.setAttribute("cateVO", cateVO);
 
//    //검색하지 않는 경우
//    //ArrayList<OverContentsVO> list = this.overcontentsProc.over_list_by_cateno(catenum);
//    
//    //검색하는 경우
//    HashMap<String, Object> hashMap = new HashMap<String, Object>();
//    hashMap.put("catenum", catenum);
//    hashMap.put("word", word);
//    ArrayList<OverContentsVO> list = this.overcontentsProc.over_list_by_cateno_search(hashMap);  

      // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
//      for (OverContentsVO overcontentsVO : list) {
//        String title = overcontentsVO.getTitle();
//        String content = overcontentsVO.getContent();
//        
//        title = Tool.convertChar(title);  // 특수 문자 처리
//        content = Tool.convertChar(content); 
//        
//        overcontentsVO.setTitle(title);
//        overcontentsVO.setContent(content);  
//
//      }
//      
//      mav.addObject("list", list);
//      
//      return mav;
//    }
    
    /**
     * 조회
     * http://localhost:9091/contents/over_read.do?contentsno=17
     * @return
     */
    @RequestMapping(value="/contents/over_read.do", method = RequestMethod.GET)
    public ModelAndView over_read(int overcontentsno) { // int cateno = (int)request.getParameter("cateno");
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/contents/over_read"); // /WEB-INF/views/contents/read.jsp
      
      OverContentsVO overcontentsVO = this.overcontentsProc.over_read(overcontentsno);
      
      String title = overcontentsVO.getTitle();
      String content = overcontentsVO.getContent();
      
      title = Tool.convertChar(title);  // 특수 문자 처리
      content = Tool.convertChar(content); 
      
      overcontentsVO.setTitle(title);
      overcontentsVO.setContent(content);  
      
      long size1 = overcontentsVO.getSize1();
      String size1_label = Tool.unit(size1);
      overcontentsVO.setSize1_label(size1_label);
      
      mav.addObject("overcontentsVO", overcontentsVO);
      
      ProCateVO procateVO = this.procateProc.cate_read(overcontentsVO.getCatenum());
      mav.addObject("procateVO",procateVO);
      overcontentsProc.over_cnt_up(overcontentsno); // 글수 증가
      
      return mav;
    }
    
    /**
     * 맵 등록/수정/삭제 폼
     * http://localhost:9091/contents/map.do?contentsno=1
     * @return
     */
    @RequestMapping(value="/contents/map.do", method=RequestMethod.GET )
    public ModelAndView map(int overcontentsno) {
      ModelAndView mav = new ModelAndView();

      OverContentsVO overcontentsVO = this.overcontentsProc.over_read(overcontentsno); // map 정보 읽어 오기
      mav.addObject("overcontentsVO", overcontentsVO); // request.setAttribute("contentsVO", contentsVO);

      ProCateVO procateVO = this.procateProc.cate_read(overcontentsVO.getCatenum()); // 그룹 정보 읽기
      mav.addObject("procateVO", procateVO); 

      mav.setViewName("/contents/map"); // /WEB-INF/views/contents/map.jsp
          
      return mav;
    }
    
    /**
     * MAP 등록/수정/삭제 처리
     * http://localhost:9091/contents/map.do
     * @param contentsVO
     * @return
     */
    @RequestMapping(value="/contents/map.do", method = RequestMethod.POST)
    public ModelAndView map_update(int overcontentsno, String map) {
      ModelAndView mav = new ModelAndView();
      
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("overcontentsno", overcontentsno);
      hashMap.put("map", map);
      
      this.overcontentsProc.map(hashMap);
      
      mav.setViewName("redirect:/contents/over_read.do?overcontentsno=" + overcontentsno); 
      // /webapp/WEB-INF/views/contents/over_read.jsp
      
      return mav;
    }

    /**
     * Youtube 등록/수정/삭제 폼
     * http://localhost:9091/contents/map.do?contentsno=1
     * @return
     */
    @RequestMapping(value="/contents/youtube.do", method=RequestMethod.GET )
    public ModelAndView youtube(HttpSession session, int overcontentsno) {
      ModelAndView mav = new ModelAndView();

      if (msadminProc.ms_isAdmin(session)) { // 관리자로 로그인한경우
          OverContentsVO overcontentsVO = this.overcontentsProc.over_read(overcontentsno); // map 정보 읽어 오기
          mav.addObject("overcontentsVO", overcontentsVO); // request.setAttribute("contentsVO", contentsVO);

          ProCateVO procateVO = this.procateProc.cate_read(overcontentsVO.getCatenum()); // 그룹 정보 읽기
          mav.addObject("procateVO", procateVO); 

          mav.setViewName("/contents/youtube"); // /WEB-INF/views/contents/youtube.jsp
          
        } else {
          mav.addObject("url", "/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
          mav.setViewName("redirect:/contents/over_msg.do"); 
        }   
      return mav;
    }
    
    /**
     * Youtube 등록/수정/삭제 처리
     * http://localhost:9091/contents/map.do
     * @param contentsno 글 번호
     * @param youtube Youtube url의 소스 코드
     * @return
     */
    @RequestMapping(value="/contents/youtube.do", method = RequestMethod.POST)
    public ModelAndView youtube_update(int overcontentsno, String youtube) {
      ModelAndView mav = new ModelAndView();
      
      if (youtube.trim().length() > 0) {  // 삭제 중인지 확인, 삭제가 아니면 youtube 크기 변경
        youtube = Tool.youtubeResize(youtube, 640);  // youtube 영상의 크기를 width 기준 640 px로 변경
      }    
      
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("overcontentsno", overcontentsno);
      hashMap.put("youtube", youtube);
      
      this.overcontentsProc.youtube(hashMap);
      
      mav.setViewName("redirect:/contents/over_read.do?overcontentsno=" + overcontentsno); 
      // /webapp/WEB-INF/views/contents/over_read.jsp
      
      return mav;
    }
    
    
    
    /**
     * 목록 + 검색 + 페이징 지원
     * 검색하는 경우 (검색 안하는 경우 word값 비움)
     * http://localhost:9092/contents/over_list_by_cateno.do?catenum=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/over_list_by_cateno.do", method = RequestMethod.GET)
    public ModelAndView over_list_by_cateno(OverContentsVO overcontentsVO) {
      ModelAndView mav = new ModelAndView();
    
      // 검색 목록
      ArrayList<OverContentsVO> list = overcontentsProc.over_list_by_cateno_search_paging(overcontentsVO);
      
      // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
      for (OverContentsVO vo : list) {
        String title = vo.getTitle();
        String content = vo.getContent();
        
        title = Tool.convertChar(title);  // 특수 문자 처리
        content = Tool.convertChar(content); 
        
        vo.setTitle(title);
        vo.setContent(content);  
    
      }
      
      mav.addObject("list", list);
    
      ProCateVO procateVO = procateProc.cate_read(overcontentsVO.getCatenum());
      mav.addObject("procateVO", procateVO);
    
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("catenum", overcontentsVO.getCatenum());
      hashMap.put("word", overcontentsVO.getWord());
      hashMap.put("type1", overcontentsVO.getType1());
      hashMap.put("type2", overcontentsVO.getType2());
      hashMap.put("type3", overcontentsVO.getType3());
      
      int over_search_count = this.overcontentsProc.over_search_count(hashMap);  // 검색된 레코드 갯수 ->  전체 페이지 규모 파악
      mav.addObject("over_search_count", over_search_count);
      
      /*
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML/CSS tag 문자열
       */
      String paging = overcontentsProc.pagingBox(overcontentsVO.getCatenum(), overcontentsVO.getNow_page(), overcontentsVO.getWord(), "over_list_by_cateno.do", over_search_count);
      mav.addObject("paging", paging);
    
      // mav.addObject("now_page", now_page);
      
      mav.setViewName("/contents/over_list_by_cateno");  // /contents/list_by_cateno.jsp
    
      return mav;
    }
    
    /**
     * 목록 + 검색 + 페이징 지원 + grid
     * 검색하는 경우 (검색 안하는 경우 word값 비움)
     * http://localhost:9091/contents/list_by_cateno_grid.do?catenum=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/over_list_by_cateno_grid.do", method = RequestMethod.GET)
    public ModelAndView over_list_by_cateno_grid(OverContentsVO overcontentsVO) {
      ModelAndView mav = new ModelAndView();
    
      // 검색 목록
      ArrayList<OverContentsVO> list = overcontentsProc.over_list_by_cateno_search_paging(overcontentsVO);
  //  //검색하는 경우
  //  HashMap<String, Object> hashMap = new HashMap<String, Object>();
  //  hashMap.put("cateno", cateno);
  //  hashMap.put("word", word);
      
      
      // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
      for (OverContentsVO vo : list) {
        String title = vo.getTitle();
        String content = vo.getContent();
        
        title = Tool.convertChar(title);  // 특수 문자 처리
        content = Tool.convertChar(content); 
        
        vo.setTitle(title);
        vo.setContent(content);  
    
      }
      
      mav.addObject("list", list);
    
      ProCateVO procateVO = procateProc.cate_read(overcontentsVO.getCatenum());
      mav.addObject("procateVO", procateVO);
    
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("catenum", overcontentsVO.getCatenum());
      hashMap.put("word", overcontentsVO.getWord());
      hashMap.put("type1", overcontentsVO.getType1());
      hashMap.put("type2", overcontentsVO.getType2());
      hashMap.put("type3", overcontentsVO.getType3());

      
      int over_search_count = this.overcontentsProc.over_search_count(hashMap);  // 검색된 레코드 갯수 ->  전체 페이지 규모 파악
      mav.addObject("over_search_count", over_search_count);
      
      /*
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML/CSS tag 문자열
       */
      // 페이지 넘길 때 사용되는 코드이므로 페이지 넘기는 버튼이 눌렸을 때 무엇이 호출될지를 지정
      String paging = overcontentsProc.pagingBox(overcontentsVO.getCatenum(), overcontentsVO.getNow_page(), overcontentsVO.getWord(), "over_list_by_cateno_grid.do", over_search_count);
      mav.addObject("paging", paging);
    
      // mav.addObject("now_page", now_page);
      
      mav.setViewName("/contents/over_list_by_cateno_grid");  // /contents/list_by_cateno_grid.jsp
    
      return mav;
    }
    

    /**
     * 수정 폼
     * http://localhost:9092/contents/over_update_text.do?overcontentsno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/over_update_text.do", method = RequestMethod.GET)
    public ModelAndView over_update_text(HttpSession session, int overcontentsno) {
      ModelAndView mav = new ModelAndView();
      
      if (msadminProc.ms_isAdmin(session)) { // 관리자로 로그인한경우
        OverContentsVO overcontentsVO = this.overcontentsProc.over_read(overcontentsno);
        mav.addObject("overcontentsVO", overcontentsVO);
        
        ProCateVO procateVO = this.procateProc.cate_read(overcontentsVO.getCatenum());
        mav.addObject("procateVO", procateVO);
        
        mav.setViewName("/contents/over_update_text"); // /WEB-INF/views/contents/update_text.jsp
        // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
        // mav.addObject("content", content);

      } else {
        mav.addObject("url", "/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
        mav.setViewName("redirect:/contents/over_msg.do"); 
      }

      return mav; // forward
    }
    
    /**
     * 수정 처리
     * http://localhost:9091/contents/over_update_text.do?overcontentsno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/over_update_text.do", method = RequestMethod.POST)
    public ModelAndView over_update_text(HttpSession session, OverContentsVO overcontentsVO) {
      ModelAndView mav = new ModelAndView();
      
      // System.out.println("-> word: " + overcontentsVO.getWord());
      
      if (this.msadminProc.ms_isAdmin(session)) { // 관리자 로그인 확인
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("overcontentsno", overcontentsVO.getOvercontentsno());
        hashMap.put("passwd", overcontentsVO.getPasswd());
        
        if (this.overcontentsProc.over_password_check(hashMap) == 1) { // 패스워드 일치
          this.overcontentsProc.over_update_text(overcontentsVO); // 글수정  
           
          // mav 객체 이용
          mav.addObject("overcontentsno", overcontentsVO.getOvercontentsno());
          mav.addObject("catenum", overcontentsVO.getCatenum());
          mav.setViewName("redirect:/contents/over_read.do"); // 페이지 자동 이동
          
        } else { // 패스워드 불일치
          mav.addObject("code", "passwd_fail");
          mav.addObject("cnt", 0);
          mav.addObject("url", "/contents/over_msg"); // msg.jsp, redirect parameter 적용
          mav.setViewName("redirect:/contents/over_msg.do");  // POST -> GET -> JSP 출력
        }
      } else { // 정상적인 로그인이 아닌 경우 로그인 유도
        mav.addObject("url", "/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
        mav.setViewName("redirect:/contents/over_msg.do"); 
      }
      
      mav.addObject("now_page", overcontentsVO.getNow_page()); // POST -> GET: 데이터 분실이 발생함으로 다시하번 데이터 저장 ★
      
      // URL에 파라미터의 전송
      // mav.setViewName("redirect:/overcontents/read.do?overcontentsno=" + overcontentsVO.getOvercontentsno() + "&cateno=" + contentsVO.getCateno());             
      
      return mav; // forward
    }

    /**
     * 파일 수정 폼
     * http://localhost:9091/contents/update_file.do?contentsno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/over_update_file.do", method = RequestMethod.GET)
    public ModelAndView over_update_file(HttpSession session, int overcontentsno) {
      ModelAndView mav = new ModelAndView();
      
      if (msadminProc.ms_isAdmin(session)) { // 관리자로 로그인한경우
        OverContentsVO overcontentsVO = this.overcontentsProc.over_read(overcontentsno);
        mav.addObject("overcontentsVO", overcontentsVO);
        
        ProCateVO procateVO = this.procateProc.cate_read(overcontentsVO.getCatenum());
        mav.addObject("procateVO", procateVO);
        
        mav.setViewName("/contents/over_update_file"); // /WEB-INF/views/contents/over_update_file.jsp
        
      } else {
        mav.addObject("url", "/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
        mav.setViewName("redirect:/contents/over_msg.do"); 
      }


      return mav; // forward
    }
    
    /**
     * 파일 수정 처리 http://localhost:9092/contents/over_update_file.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/over_update_file.do", method = RequestMethod.POST)
    public ModelAndView over_update_file(HttpSession session, OverContentsVO overcontentsVO) {
      ModelAndView mav = new ModelAndView();
      
      if (this.msadminProc.ms_isAdmin(session)) {
        // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
        OverContentsVO overcontentsVO_old = overcontentsProc.over_read(overcontentsVO.getOvercontentsno());
        
        // -------------------------------------------------------------------
        // 파일 삭제 시작
        // -------------------------------------------------------------------
        String file1saved = overcontentsVO_old.getFile1saved();  // 실제 저장된 파일명
        String thumb1 = overcontentsVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
        long size1 = 0;
           
        String upDir =  OverContents.getUploadDir(); // C:/kd/deploy/resort_v2sbm3c/contents/storage/
        
        Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
        Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
        // -------------------------------------------------------------------
        // 파일 삭제 종료
        // -------------------------------------------------------------------
            
        // -------------------------------------------------------------------
        // 파일 전송 시작
        // -------------------------------------------------------------------
        String file1 = "";          // 원본 파일명 image

        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF' 
        //           value='' placeholder="파일 선택">
        MultipartFile mf = overcontentsVO.getFile1MF();
            
        file1 = mf.getOriginalFilename(); // 원본 파일명
        size1 = mf.getSize();  // 파일 크기
            
        if (size1 > 0) { // 폼에서 새롭게 올리는 파일이 있는지 파일 크기로 체크 ★
          // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
          file1saved = Upload.saveFileSpring(mf, upDir); 
          
          if (Tool.isImage(file1saved)) { // 이미지인지 검사
            // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
            thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
          }
          
        } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
          file1="";
          file1saved="";
          thumb1="";
          size1=0;
        }
            
        overcontentsVO.setFile1(file1);
        overcontentsVO.setFile1saved(file1saved);
        overcontentsVO.setThumb1(thumb1);
        overcontentsVO.setSize1(size1);
        // -------------------------------------------------------------------
        // 파일 전송 코드 종료
        // -------------------------------------------------------------------
            
        this.overcontentsProc.over_update_file(overcontentsVO); // Oracle 처리

        mav.addObject("overcontentsno", overcontentsVO.getOvercontentsno());
        mav.addObject("catenum", overcontentsVO.getCatenum());
        mav.setViewName("redirect:/contents/over_read.do"); // request -> param으로 접근 전환
                  
      } else {
        mav.addObject("url", "/admin/ms_login_need"); // login_need.jsp, redirect parameter 적용
        mav.setViewName("redirect:/contents/over_msg.do"); // GET
      }

      // redirect하게되면 전부 데이터가 삭제됨으로 mav 객체에 다시 저장
      mav.addObject("now_page", overcontentsVO.getNow_page());
      
      return mav; // forward
    }   
    /**
     * 파일 삭제 폼
     * http://localhost:9092/contents/over_delete.do?overcontentsno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/over_delete.do", method = RequestMethod.GET)
    public ModelAndView over_delete(HttpSession session, int overcontentsno) {
      ModelAndView mav = new ModelAndView();
      
      if (msadminProc.ms_isAdmin(session)) { // 관리자로 로그인한경우
        OverContentsVO overcontentsVO = this.overcontentsProc.over_read(overcontentsno);
        mav.addObject("overcontentsVO", overcontentsVO);
        
        ProCateVO procateVO = this.procateProc.cate_read(overcontentsVO.getCatenum());
        mav.addObject("procateVO", procateVO);
        
        mav.setViewName("/contents/over_delete"); // /WEB-INF/views/contents/delete.jsp
        
      } else {
        mav.addObject("url", "/admin/ms_login_need"); // /WEB-INF/views/admin/login_need.jsp
        mav.setViewName("redirect:/contents/over_msg.do"); 
      }


      return mav; // forward
    }

    /**
     * 삭제 처리 http://localhost:9091/contents/over_delete.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/over_delete.do", method = RequestMethod.POST)
    public ModelAndView over_delete(OverContentsVO overcontentsVO) {
      ModelAndView mav = new ModelAndView();
      
      // -------------------------------------------------------------------
      // 파일 삭제 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      OverContentsVO overcontentsVO_read = overcontentsProc.over_read(overcontentsVO.getOvercontentsno());
          
      String file1saved = overcontentsVO.getFile1saved();
      String thumb1 = overcontentsVO.getThumb1();
      
      String uploadDir = OverContents.getUploadDir();
      Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
      Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료
      // -------------------------------------------------------------------
          
      this.overcontentsProc.over_delete(overcontentsVO.getOvercontentsno()); // DBMS 삭제
          
      // -------------------------------------------------------------------------------------
      // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
      // -------------------------------------------------------------------------------------    
      // 마지막 페이지의 마지막 10번째 레코드를 삭제후
      // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
      // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
      int now_page = overcontentsVO.getNow_page();
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("catenum", overcontentsVO.getCatenum());
      hashMap.put("word", overcontentsVO.getWord());
      
      if (overcontentsProc.over_search_count(hashMap) % OverContents.RECORD_PER_PAGE == 0) {
        now_page = now_page - 1; // 삭제시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
        if (now_page < 1) {
          now_page = 1; // 시작 페이지
        }
      }
      // -------------------------------------------------------------------------------------
      procateProc.cate_update_cnt_down(overcontentsVO.getCatenum()); // 글수 증가
      mav.addObject("catenum", overcontentsVO.getCatenum());
      mav.addObject("now_page", now_page);
      mav.setViewName("redirect:/contents/over_list_by_cateno.do"); 
      
      return mav;
    }  
    
    // http://localhost:9091/contents/over_delete_by_cateno.do?cateno=1
    // 파일 삭제 -> 레코드 삭제
    @RequestMapping(value = "/contents/over_delete_by_cateno.do", method = RequestMethod.GET)
    public String over_delete_by_cateno(int catenum) {
      ArrayList<OverContentsVO> list = this.overcontentsProc.over_list_by_cateno(catenum);
      
      for(OverContentsVO overcontentsVO : list) {
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
      
      int cnt = this.overcontentsProc.over_delete_by_cateno(catenum);
      System.out.println("-> count: " + cnt);
      
      return "";
    
    }
    /**
     * 갤러리 화면으로 이미지 변경
     * http://localhost:9091/contents/over_list.do
     * @return
     */
    @RequestMapping(value="/contents/over_list_all_gallery.do", method = RequestMethod.GET)
    public ModelAndView over_list_all_gallery(HttpSession session) {
      ModelAndView mav = new ModelAndView();
    
      mav.setViewName("/contents/over_list_all_gallery"); // /WEB-INF/views/contents/over_list_all_gallery.jsp
      ArrayList<OverContentsVO> list = this.overcontentsProc.over_list_all();
      mav.addObject("list", list);
        
      
      return mav;
    }
    
}
