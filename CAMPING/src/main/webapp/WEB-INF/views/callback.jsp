<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	callback
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("eT2NCIHgedo2uVebssZm",
				"http://localhost:8080/oauth2/naver/callback.do"); 
		// 접근 토큰 값 출력 
		alert(naver_id_login.oauthParams.access_token); 
		// 네이버 사용자 프로필 조회 
		naver_id_login.get_naver_userprofile("naverSignInCallback()"); 
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function 
		function naverSignInCallback() { 
			 $.ajax({
			       url: "http://localhost:8080/oauth2/naver/callback.do#access_token=AAAANi9DaihYFXQF1fwjZm2gvZKxMMo-pae_toBewFrayZrlLEc_ZSXrltciQaVAD1ufBQyQf0ruLnPdJ0LHiRoymFQ&state=c86238b0-ea2f-4616-9e48-77efae13e826&token_type=bearer&expires_in=3600",
			       type: "get",
			       contentType: "application/json; charset=utf-8;",
			       dataType : "json",
			       success: function(result){
			       	console.log(result)
			       }	
			       fail: function(error) {
		            console.log(error);
			});
	<!-- 	alert(naver_id_login.getProfileData('name')); 
		alert(naver_id_login.getProfileData('email')); 
		alert(naver_id_login.getProfileData('nickname')); 
		alert(naver_id_login.getProfileData('id'));
		alert(naver_id_login.getProfileData('birthyear'));
		alert(naver_id_login.getProfileData('birthday'));
		alert(naver_id_login.getProfileData('mobile')); }
	 -->
	</script>
	
</body>
</html>



