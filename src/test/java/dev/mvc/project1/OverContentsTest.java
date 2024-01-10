package dev.mvc.project1;


import java.util.HashMap;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import dev.mvc.msadmin.MsAdminProcInter;
import dev.mvc.msadmin.MsAdminVO;
import dev.mvc.procate.ProCateProcInter;
import dev.mvc.overcontents.OverContentsProcInter;

@SpringBootTest
public class OverContentsTest {
  @Autowired
  @Qualifier("dev.mvc.msadmin.MsAdminProc") // "dev.mvc.admin.AdminProc"라고 명명된 클래스
  private MsAdminProcInter msadminProc; // AdminProcInter를 구현한 AdminProc 클래스의 객체를 자동으로 생성하여 할당

  @Autowired
  @Qualifier("dev.mvc.procate.ProCateProc")  // @Component("dev.mvc.cate.CateProc")
  private ProCateProcInter procateProc;
  
  @Autowired
  @Qualifier("dev.mvc.overcontents.OverContentsProc") // @Component("dev.mvc.contents.ContentsProc")
  private OverContentsProcInter overcontentsProc;
  
  @Test
  public void testRead() {
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("overcontentsno", 17);
    hashMap.put("passwd", "1234");
    
    System.out.println("-> cnt: " + this.overcontentsProc.over_password_check(hashMap));
    
  }
}
