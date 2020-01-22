<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/table.css"/>
<div>
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>지원내역 조회</h2>
    </div>
</div>
<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                KJN리조트와 함께 할 패기 넘치는 인재를 기다립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
            	<sec:authentication property="principal" var="pinfo"/>
            	<sec:authorize access="isAuthenticated()">
	                <table class="table table-bordered table-hover" style="width: 70%; margin: auto;">	   
	                    <thead class="thead-light">
	                        <tr>
	                            <th>이름</th>
	                            <th>핸드폰 번호</th>
	                            <th>지원상태</th>
	                            <th>제출일</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <c:forEach items="${list}" var="appliance">
	                   	 <c:if test="${pinfo.username eq appliance.id }">
	                        <tr>
	                            <td>${appliance.name}</td>
	                            <td>${appliance.phoneNumber}</td>
	                            <td>${appliance.status}</</td>
	                           	<td><fmt:formatDate value="${appliance.regDate}" pattern="yy-MM-dd"/></td>
	                        </tr>
	                      </c:if>
	                    </c:forEach>
	                    </tbody>
	                </table><!-- END 게시물 출력 테이블 -->
	                <form method="get" id="operForm" >	
             			<input type="hidden" name="id" value='<sec:authentication property="principal.username"/>'>
	               		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
             		</form> 
	                <button id="regBtn" type="button" class="btn btn-primary pull-right">
	          			지원서 작성	
	          		</button>
   				</sec:authorize>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->

<script>
$(function(){	
	var operForm = $("#operForm");
	
	$('#regBtn').on("click",function(){
		operForm.attr("action","/appliance/register").submit();
	});
});
</script>

<%@ include file="../includes/footer.jsp" %>