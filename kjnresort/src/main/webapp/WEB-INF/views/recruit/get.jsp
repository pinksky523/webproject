<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">모집공고 게시판</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <!-- /.panel-heading -->
            <div class="panel-body">
            
		            <div class="form-group">
		                <label>제목: </label>
		                <input class="form-control" name="title"
		                value="${recruit.title }" readonly></div>
		            <div class="form-group">
		                <label>글 번호: </label>
		                <input class="form-control" name="recruitNo"
		                value="${recruit.recruitNo }" readonly></div>
		            <div class="form-group">
		                <label>상태: </label>
		                <input class="form-control" name="status"
		                value="${recruit.status }" readonly></div>
		            <div class="form-group">
		                <label>접수마감: </label>
		                <input class="form-control" name="deadLine"
		                value="${recruit.deadLine}" readonly></div>
		            <div class="form-group">
	                    <label>내용: </label>
	                    <textarea class="form-control" rows="8" name="content"
	                     readonly>${recruit.content}</textarea></div>
	             <!-- 로그인 안 한 경우 -->
				<sec:authorize access="isAnonymous()">
	                <button data-oper='register' onclick="location.href='/common/customLogin'" class="btn btn-primary pull-right">지원하기</button>
	            </sec:authorize>
	                <button data-oper='modify' class="btn btn-warning pull-right">수정</button>
	                <button data-oper='remove' class="btn btn-danger pull-right">삭제</button>
	                <button data-oper='list' class="btn btn-secondary pull-right">목록</button>
               <form id="operForm" action="/recruit/modify" method="get">
             		<input type="hidden" id="recruitNo" name="recruitNo" value='<c:out value="${recruit.recruitNo}"/>'>
             	</form>
				
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<script>
$(document).ready(function(){
	
	var operForm = $("#operForm");
	
	$("button[data-oper='register']").on("click", function(e){
		operForm.attr("action","/appliance/register").submit();
	});
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action","/recruit/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#recruitNo").remove();
		operForm.attr("action","/recruit/list").submit();
	});
});

</script>

<%@ include file="../includes/footer.jsp" %>