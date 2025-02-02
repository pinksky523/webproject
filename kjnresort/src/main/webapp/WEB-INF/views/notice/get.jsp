<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:authorize access="isAnonymous()">
		<%@ include file="../includes/header.jsp" %>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="pinfo"/>
	<c:choose>
	
		<c:when test="${pinfo.username eq 'admin'}">
			<%@ include file="../includes/adminHeader.jsp" %>
		</c:when>
		
		<c:otherwise>
			<%@ include file="../includes/header.jsp" %>
		</c:otherwise>
	</c:choose>
</sec:authorize>

<style>
h2{text-align: center;}
.pagination{justify-content: center; bottom:30px;}
body{height:900px !important;}
footer{margin-top:300px !important;}
button{margin-left: 5px; margin-right: 5px;}
</style>

<h2>공지사항</h2>


	<div class="container" style="height: 400px; margin-bottom:200px; font-size:2rem; width:1000px !important;">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                 공지사항, 상품안내 등의 소식 등을 모아 고객에게 빠르게 전달해 드립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
		            <div class="form-group">
		                <label>제목 : </label>
		                <input class="form-control" name="title"
		                value="${notice.title }" readonly></div>
		            <div class="form-group">
		                <label>글 번호 : </label>
		                <input class="form-control" name="recruitNo"
		                value="${notice.noticeNo }" readonly></div>
		            <div class="form-group">
		                <label>작성일시 : </label>
		                <input class="form-control" name="regDate"
		                value='<fmt:formatDate value="${notice.regDate }" pattern="yy-MM-dd"/>'  readonly></div>
		            <div class="form-group">
		                <label>조회수 : </label>
		                <input class="form-control" name="viewCnt" 
		                value="${notice.viewCnt}" readonly></div>
		            <div class="form-group">
	                    <label>내용 : </label>
	                    <textarea class="form-control" rows="8" name="content"
	                     readonly>${notice.content}</textarea></div>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
							<button data-oper='remove' class="btn btn-danger pull-right">삭제</button>
							<button data-oper='modify' class="btn btn-warning pull-right">수정</button>
		             	<form action="/notice/modify" method="get" id="operForm" >	
		             		<input type="hidden" id="noticeNo" name="noticeNo" value='<c:out value="${notice.noticeNo}"/>'>
		             		<input type="hidden" name="id" value='<sec:authentication property="principal.username"/>'>
			                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		             	</form>          		
					</sec:authorize>
							<button id="regBtn" class="btn btn-secondary pull-right">목록</button>

            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<script>

$(document).ready(function(){
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action","/notice/modify").submit();
	});
	
	$("button[data-oper='remove']").on("click", function(e){
		if(confirm("정말 삭제하시겠습니까?")) {
			alert("삭제가 완료되었습니다.")
			operForm.attr("action","/notice/remove").attr("method","post");
			operForm.submit();
		}
	});
	
	$('#regBtn').on("click",function(){
		self.location = "/notice/list";
	});
});

</script>

<%@ include file="../includes/footer.jsp" %>