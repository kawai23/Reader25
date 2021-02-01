<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>




<style>

	
#footer-company{margin-bottom: 30px;}

</style>
</head>
<body>

 <%@ include file="../common/menubar.jsp"%> <br><br><br>

<div class="container-fluid" style="justify-content: center;"> 

 	<div class="row">
 
 
 
 
 	  <div class="col-sm-2"></div>
 	  
 	   <%@ include file="../common/mySideMenubar.jsp"%> 

	  
	  
	  
	  
	  
	  
	   <div class="col-sm-6" style="border: 1px solid black;" >
	   
	   <table id="mytable" class="table table-bordred table-striped" >

					<thead>

	 					<tr>
							<th><input type="checkbox" id="checkall" /></th>
							
							<th style="max-width: 50px">게시물번호 </th>
							<th >책이름</th>
							
							<th>수량</th>
							<th>가격</th>
						
							
							
							
						 </tr>
					</thead>

					<tbody>
					
					<c:if test="${empty list}">
					
						<tr>
							<td colspan="6">조회된 리스트가 없습니다.</td>
						</tr>
					
					</c:if>
					
					
						<c:forEach var="b" items="${ list }">

							<tr>
								<td><input type="checkbox"  name="mInfo" value="${ b.sb_no }" ></td>
								
								<td class="contentTR"  >${ b.book_no }</td>
								
								
								<td class="contentTR"  style="max-width: 100px" >${ b.book_name }</td>
								<td class="contentTR">${  b.sb_v }</td>
								<td class="contentTR">${ b.price }</td>
								
								<td style="display: none;">${ b.BOARD_NO }</td>
								
								
								
								
								
							</tr>
							
							
							</c:forEach>

			
					


					</tbody>

				</table>
				
				<div style="text-align: left ; ">
				
					<button  data-title="Delete" data-toggle="modal" data-target="#Delete"  class="btn btn-danger">선택삭제</button>
					<button  class="btn btn-primary" id = "eBtn"  >주문 하기</button>
				
				</div>
				
				
			
			
			<br>
			<div style=" text-align: center;" >
			
				<div class="input-group" style="width: 300px;  "> 

							<div class="input-group-btn" >
								<button type="button" class="btn btn-default dropdown-toggle"
									id="Search1" data-toggle="dropdown" aria-expanded="false">번호
									<span class="caret" style="margin-left: 10px"></span>
								</button>
								<ul class="dropdown-menu" role="menu" id="search1" style="overflow: visible;">
									
									<li value="Title"><a href="#">책이름</a></li>
									<li value="내용"><a href="#">번호</a></li>
								</ul>
							</div>
							<!-- /btn-group -->

							<input type="text" class="form-control" id="seachDate" > 
							
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" id="searchList">검색</button>
								
								
							</span>
							
							
						</div>	
							
				</div>
						
			
				
				
				
				
				
				
				
				
				
				
				
				<script >
				
				
				
				$(function(){
					
		
						$('#bs').addClass('active');
						
						
						
						

					
					});
				


				
				
				
				
				
				
				
			
				
				 $('#searchList').click(function() {
			    	
			    	
			    	
			    	var data = '';
			    	
			    	
			    		
			    		
			    	var searchCondition = $('#Search1').text();
			    	var searchValue = $('#seachDate').val();
	
			    	
			    	console.log(data);
			    
			    	
 		    	location.href='myBasketList.me?searchCondition='+searchCondition+'&searchValue='+searchValue; 
			    	 
			 
			    
				});
				 
				 
				 
				 
				 $(document).ready(function(){
						$("#mytable #checkall").click(function () {
						        if ($("#mytable #checkall").is(':checked')) {
						            $("#mytable input[type=checkbox]").each(function () {
						                $(this).prop("checked", true);
						            });

						        } else {
						            $("#mytable input[type=checkbox]").each(function () {
						                $(this).prop("checked", false);
						            });
						        }
						    });
						    
						
						});
				 
				 </script>


			
			
			<nav style="text-align: center;">
				 <ul class="pagination">
				      
		
					
						<c:set var="loc" value="myBasketList.me"></c:set>
						
 
				    
				  <!-- [이전] -->
				  
				 
				  
				  
				  <c:if test="${ pi.currentPage <= 1 }">
					 <li  class="disabled">
						 <a  aria-label="Previous" >
					        <span aria-hidden="true" class="glyphicon glyphicon-backward"></span>
					      </a>
				      </li>
				</c:if>
				<c:if test="${ pi.currentPage > 1 }">
					<c:url var="before" value="${ loc }">
						<c:param name="page" value="${ 1 }"/>
						<c:param name="code" value="${code }"></c:param>
						
						
						<c:if test="${searchValue ne null }">
						
							<c:param name="searchCondition" value="${searchCondition }"></c:param>
							<c:param name="searchValue" value="${searchValue }"></c:param>
						
						
						</c:if>
						
					</c:url>
					
					<li>
						 <a href="${ before }" aria-label="Previous">
					        <span class="glyphicon glyphicon-backward" aria-hidden="true"></span>
					      </a>
				      </li>
					
				</c:if>
				  
				  
				  
				<c:if test="${ pi.currentPage <= 1 }">
					 <li  class="disabled">
						 <a  aria-label="Previous" >
					        <span aria-hidden="true" class="glyphicon glyphicon-chevron-left"><!--  &laquo; --></span>
					      </a>
				      </li>
				</c:if>
				<c:if test="${ pi.currentPage > 1 }">
					<c:url var="before" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage - 1 }"/>
						<c:param name="code" value="${code }"></c:param>
						
						
						<c:if test="${searchValue ne null }">
						
							<c:param name="searchCondition" value="${searchCondition }"></c:param>
							<c:param name="searchValue" value="${searchValue }"></c:param>
						
						
						</c:if>
						
					</c:url>
					
					 <li>
						 <a href="${ before }" aria-label="Previous">
					        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					      </a>
				      </li>
				</c:if>
				
				
				
				    
				    <!-- 페이지 -->
				<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
					<c:if test="${ p eq pi.currentPage }">
						
						
						 <li class="active"><a >${ p }</a></li>
					</c:if>
					
					<c:if test="${ p ne pi.currentPage }">
						<c:url var="pagination" value="${ loc }">
						
							<c:param name="page" value="${ p }"/>
							<c:param name="code" value="${code }"></c:param>
					
						
						
							<c:if test="${searchValue ne null }">
						
								<c:param name="searchCondition" value="${searchCondition }"></c:param>
								<c:param name="searchValue" value="${searchValue }"></c:param>
								
						
							</c:if>
						</c:url>
						
						<li><a href="${ pagination }">${ p }</a></li>
					</c:if>
				</c:forEach>
				    
				    
				    
				<!-- [다음] -->
						<c:if test="${ pi.currentPage >= pi.maxPage }">
						<li class="disabled">
							<a  aria-label="Next">
				       				 <span class="glyphicon glyphicon-chevron-right" aria-hidden="true">        <!-- &raquo--></span>
				      			</a>
				      			</li>
						</c:if>
						
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="after" value="${ loc }">
								<c:param name="page" value="${ pi.currentPage + 1 }"/>
								<c:param name="code" value="${code }"></c:param>
								
								<c:if test="${searchValue ne null }">
						
									<c:param name="searchCondition" value="${searchCondition }"></c:param>
									<c:param name="searchValue" value="${searchValue }"></c:param>
									
							
								</c:if>
							</c:url> 
							
							<li>
							<a  href="${ after }" aria-label="Next">
				       				 <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				      			</a>
				      			</li>
						</c:if>
						
						
						<c:if test="${ pi.currentPage >= pi.maxPage }">
						<li class="disabled">
							<a  aria-label="Next">
				       				 <span class="glyphicon glyphicon-forward" aria-hidden="true"></span>
				      			</a>
				      			</li>
						</c:if>
						
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="after" value="${ loc }">
								<c:param name="page" value="${ pi.maxPage }"/>
								<c:param name="code" value="${code }"></c:param>
								
								<c:if test="${searchValue ne null }">
						
									<c:param name="searchCondition" value="${searchCondition }"></c:param>
									<c:param name="searchValue" value="${searchValue }"></c:param>
									
							
								</c:if>
							</c:url> 
							
							<li>
							<a  href="${ after }" aria-label="Next">
				       				 <span class="glyphicon glyphicon-forward" aria-hidden="true"></span>
				      			</a>
				      			</li>
						</c:if>
				  </ul>
			            
			</nav>        
			
			</div>
				            
				    
						
		
	   
	   
	   </div>
	   
	
	</div>
	
    <br><br><br>
	 <%@ include file="../common/footer.jsp" %>
   
	

    
    
    
	
	 <div class="modal fade" id="Delete" tabindex="-1" role="dialog"
							aria-labelledby="edit" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</button>
										<h4 class="modal-title custom_align" id="Heading">Delete</h4>
									</div>
									<div class="modal-body">
					
										<div class="alert alert-danger">
											<span class="glyphicon glyphicon-warning-sign"></span> 정말로
											삭제하시겠습니까??
										</div>
					
									</div>
									<div class="modal-footer ">
										<button type="button" class="btn btn-success" id="yBtn">
											<span class="glyphicon glyphicon-ok-sign"></span> Yes
										</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">
											<span class="glyphicon glyphicon-remove"></span> No
										</button>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>						<br><br><br>
 
  
						
						
						
						
						
						<c:if test="${ !empty searchValue}">
					
							<c:set var="check" value="true"></c:set>
					
					   </c:if>
					   
					   <c:if test="${ empty searchValue}">
					
							<c:set var="check" value="false"></c:set>
					
					   </c:if>
						

	<script>
	
	
	$('#search1 li > a').on('click', function() {
    	
    	
		   
	    $('#Search1').text($(this).text());
	    
	    $('#Search1').append('<span class="caret" style="margin-left: 10px"></span>'); 
	    // 선택된 항목 값(value) 얻기
	    
	    
	    
	});
						
						
						
						 $('#yBtn').click(function() {
					        	
					        	
					        	
								
					        	
					        	
					        	var check = ${ check } ; 
					        	
					        	var searchCondition = null;
					        	
					        	var searchValue = null;
					        	
					        	var path= "";
					        
					        	if(check ){
					        		
					        		
					        		searchCondition = "${searchCondition}";
					        		searchValue= "${searchValue}";
					        		
					        		
					        		path = '&searchCondition='+searchCondition+'&searchValue='+searchValue;
					        	}
					        	
					        	
					        	
					        	
								var select_obj = '';
								 
								
							    $('input[name="mInfo"]:checked').each(function (index) {
							        if (index != 0) {
							            select_obj += ',';
							        }
							        select_obj += $(this).val();
							        
							        
							        
							    });
							    
							    
							    
							  
							    	
				 			   
							 location.href='myBasketDelete.me?inFo='+select_obj+ '&page='+ ${pi.currentPage}+path;
							    	
				 			   
							    

						});
						 
						 
						 $('#eBtn').click(function() {
					        	
					        	
					        	
								
					        	
					        	
							 var b_no = [];
							var book_v = [];
								 
								
							    $('input[name="mInfo"]:checked').each(function (index) {
//							        if (index != 0) {
//							            select_obj += ',';
//							        }
							        
//							        select_obj += $(this).val();
							        
							        b_no.push($(this).parent().parent().children('td').eq(1).text());
							        
							        
							        book_v.push($(this).parent().parent().children('td').eq(3).text());
							        
							       
							        
							        
							    });
							    
							    
							    console.log(b_no);
							    
							    console.log(book_v);
							    
							    
								var path = ""
							    
								
								
							    if(b_no != ""){
							    	
							    	path = "?b_no="+b_no+"&book_v="+book_v;
							    }

								
								location.href= "cart.bo" +path;
							    	
				 			   
							    

						});
						 
						 
						 $('.contentTR').mouseenter(function(){
								
								$(this).parent().children('td').css({'font-weight' : 'bold' , 'cursor' : 'pointer'});
								
								
								
							}).mouseout(function(){
								
								$(this).parent().children('td').css({'color':'black' , 'font-weight' : 'normal'});
								
								
							}).click(function(){
								
								
								
								

							
						
							   var boardNo = $(this).parent().children('td').eq(5).text();
							   
							   var b_no = $(this).parent().children('td').eq(1).text();
							   
							   
							   console.log(b_no);
								

								
 								location.href=  'redetail.bo?boardNo='+boardNo+"&b_no="+b_no+"&page=1";
 								
 								
								
							});
						
						
				       
						
						
						
						
						</script>
						


</body>
</html>