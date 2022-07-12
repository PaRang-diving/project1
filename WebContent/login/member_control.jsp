<%@page import="java.sql.*"%>

<%@ page import="web.memberMgr.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="memDao" class="web.memberMgr.MemberDAO" />
<jsp:useBean id="memVo" class="web.memberMgr.MemberVO" />
<jsp:setProperty name="memVo" property="*"/> 

<% 
	
	String action = request.getParameter("action");	// joinForm.jsp의 form 태그 안의 네임이 action 인 영역의 값을 가져와서 String 변수 action에 담는다. 
	
	System.out.println("action ::: "+ action);
	System.out.println("request ::: "+ request);
	System.out.println("memVo id ::: "+ memVo.getMember_id());

	// java에 연결되는지 보자..
	
// 	int chk = memDao.chkDupl(memVo);
// 	System.out.println("chk ::: "+ chk);
	
// 	if(chk > 0) {
// 		pageContext.setAttribute("memVo", memVo);
// 		pageContext.forward("joinForm.jsp");
// 		return;
// 	}
	
	if("insert".equals(action)) {				// insert 인 경우에는 db에 저장하기로 했음.
		
		System.out.println("인서트 실행");
		
		boolean insertRslt = memDao.insert(memVo);
		
		System.out.println("화면으로 받은 결과 ??? "+insertRslt);
		
		if(insertRslt) {	// 방어코드.
			pageContext.forward("joinComplete.jsp?isLogin="+insertRslt);
		} else {
			pageContext.setAttribute("memVo", memVo);
			pageContext.forward("joinForm.jsp");
			
		}
		
	} else if("chk".equals(action)) {		// chk인 경우에는 db를 조회해서 결과가 있는지 여부를 반환 받기로 했음.
		
		// 이때에는 javaDao에 있는 다른 메소드를 호출해서 수행해보자...
		int memCheck = memDao.memberCheck(memVo.getMember_id());
		
		System.out.println("???? 멤버아이디 ::: "+memVo.getMember_id());
		
		System.out.println("memCheck반환값 : "+ memCheck);
		
		if(memCheck > 0) {	// memCheck 가 1 인 경우
			pageContext.forward("joinForm.jsp?isDupl='Y'");
		} else {		// memCheck 가 -1 인 경우
			pageContext.forward("joinForm.jsp?isDupl='N'");
		}
		
		
		
	}
	
	
	
// 	if(action.equals("list")) {
// 		ArrayList<MemberVO> datas = mem.getDBList();
// 		request.setAttribute("datas", datas);
// 		pageContext.forward("memb_list.jsp");
// 	}
// 	// 주소록 등록 요청인 경우
// 	else if(action.equals("insert")) {		
// 		if(mem.insert(memb)) {
// 			response.sendRedirect("member_control.jsp?action=list");
// 		}
// 		else
// 			throw new Exception("DB 입력오류");
// 	}
// 	// 주소록 수정 페이지 요청인 경우
// 	else if(action.equals("edit")) {
// 		MemberVO member = mem.getDB(memb.getMember_id());
// 		if(!request.getParameter("upasswd").equals("1234")) {
// 			out.println("<script>alert('비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
// 		}
// 		else {
// 			request.setAttribute("mem",abook);
// 			pageContext.forward("member_edit_form.jsp");
// 		}
// 	}
// 	// 주소록 수정 등록 요청인 경우
// 	else if(action.equals("update")) {
// 			if(mem.updateDB(memb)) {
// 				response.sendRedirect("member_control.jsp?action=list");
// 			}
// 			else
// 				throw new Exception("DB 갱신오류");
// 	}
// 	// 주소록 삭제 요청인 경우
// 	else if(action.equals("delete")) {
// 		if(mem.deleteDB(memb.getAb_id())) {
// 			response.sendRedirect("addrbook_control.jsp?action=list");
// 		}
// 		else
// 			throw new Exception("DB 삭제 오류");
// 	}
// 	else {
// 		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
// 	}
%>
