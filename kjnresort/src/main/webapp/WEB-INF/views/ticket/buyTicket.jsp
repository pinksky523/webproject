<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>    
<br><br><br>
	<div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>이용권 구매</h2>
    </div>
	<hr>
	<form id="buyForm" method="get" action="buyTicketKakao">
   <table width="100%" style="padding:5px 0 5px 0; ">
   	
      <tr>
         <th>리프트권 선택</th>
         <td>리프트 미선택                      <input type="radio" name="lift" class="form-control" id="liftNoUse" value="0" style="width: 35%"></td>
         <td>4시간 이용권(<c:out value="${tPrice.price}"/>원/1매)<input type="radio" name="lift" class="form-control" id="liftUse"   value="1" style="width: 35%" checked="checked"></td>
      </tr>
      
      <tr>
         <th><span id="liftAmount">수량 선택
         
        <select name="liftAmount" class="form-control" id="Amount"  style="width: 70%">
        	<option value="0">0 </option>
        	<option value="1">1 </option>
        	<option value="2">2 </option>
        	<option value="3">3 </option>
        	<option value="4">4 </option>
        	<option value="5">5 </option> 
        </select> </span>	</th>
       </tr>
       <tr>
         <th>장비렌탈 선택</th>
         <td>장비렌탈 미선택<input type="radio" name="tool" class="form-control" id="toolNoUse" value="0" style="width: 35%" ></td>
         <td>4시간 이용권(<c:out value="${ttPrice.price}"/>원/1매)<input type="radio" name="tool" class="form-control" id="toolUse" value="1" style="width: 35%" checked="checked"></td>
       </tr>
       
       <tr>
         <th> <span id="toolAmount">수량 선택
         
        <select name="toolAmount" class="form-control" id="Amount"  style="width: 70%">
        	<option value="0">0</option>
        	<option value="1">1</option>
        	<option value="2">2</option>
        	<option value="3">3</option>
        	<option value="4">4</option>
        	<option value="5">5</option>
        </select>	</span> </th>
       </tr>
       <tr>
       		<th>총금액</th>
       		<td><span name="totalPrice" id="text1" class="form-control">원</span></td>

       </tr>
       <tr>
         <td colspan="2" align="right">
         	<input type="hidden" name="id" value="user00">
         	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		    <button type="submit" class="btn btn-primary" id="buyForm">다음</button>
         </td>
       </tr>
    </table>
</form>
<br><br><br><br>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<script>

$(function(){	
	
	
	$("select[id=Amount]").change(function(obj){
 		var str = document.getElementById("text1");
 		var lift = ($("select[name=liftAmount]").val() * ${tPrice.price});
 		var tool = ($("select[name=toolAmount]").val() * ${ttPrice.price});
 	
 		 if($("input[name=lift]:checked").val()  && $("input[name=tool]:checked").val()) {
 			document.getElementById("text1").innerHTML = (lift + tool) + "원";
 		} 
	}); 
	
	$("select[id=Amount]").change(function(obj){
		var lift = ($("select[name=liftAmount]").val() * ${tPrice.price});
 		var tool = ($("select[name=toolAmount]").val() * ${ttPrice.price});
 		 if($("input[name=lift]:checked").val()  && $("input[name=tool]:checked").val() == "0") {
 			document.getElementById("text1").innerHTML = lift + "원";
 		}
	});
	
	$("select[id=Amount]").change(function(obj){
		var lift = ($("select[name=liftAmount]").val() * ${tPrice.price});
 		var tool = ($("select[name=toolAmount]").val() * ${ttPrice.price});
 		 if($("input[name=lift]:checked").val() == "0"  && $("input[name=tool]:checked").val()) {
 			document.getElementById("text1").innerHTML = tool + "원";
 		}
	});
	// 라디오버튼 클릭시 이벤트 발생
	$("input:radio[name=lift]").click(function(){
		 
        if($("input[name=lift]:checked").val() == "1"){
            $("#liftAmount").attr("hidden",false);
            // radio 버튼의 value 값이 1이라면 활성화
 
        }else if($("input[name=lift]:checked").val() == "0"){
              $("#liftAmount").attr("hidden",true);
            // radio 버튼의 value 값이 0이라면 비활성화
        }
    });
	
    $("input:radio[name=tool]").click(function(){
    	 
        if($("input[name=tool]:checked").val() == "1"){
            $("#toolAmount").attr("hidden",false);
            // radio 버튼의 value 값이 1이라면 활성화
 
        }else if($("input[name=tool]:checked").val() == "0"){
              $("#toolAmount").attr("hidden",true);
            // radio 버튼의 value 값이 0이라면 비활성화
        }
    });
    
    
});
	
</script>


<%@ include file="../includes/footer.jsp" %>