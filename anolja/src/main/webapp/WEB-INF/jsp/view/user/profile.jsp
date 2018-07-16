<%@ page contentType="text/html; charset=UTF-8"%>

	<script type="text/javascript">
	var popupX = ((window.screen.width / 2) / 4) * 2;
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= ((window.screen.height / 2) / 4) * 1.5;
	// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	
    document.body.style.overflow='hidden';  
    if (navigator.userAgent.indexOf('Chrome')>-1) {
			    window.resizeTo(900, 700);
			  	window.moveTo(popupX, popupY);
    }
   
	var body = document.querySelector('body');
	
	body.innerHTML = '';

	var sidebar = document.createElement('div');
	var sidebarnav = document.createElement('ul');
	
	var html = ''; 
	html += '<li><a id="mypage-navbar-toggle">Close <i class="fa fa-bars menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	html += '<li><a href="#">Home <i class="fa fa-home menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	html += '<a href="#">Edit<i class="fa fa-cog menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	
	$(sidebarnav).html(html);
	$(sidebar).append(sidebarnav);
	
	
// 	 <div class="mypage-sidebar">
//      <ul class="mypage-sidebar-nav">
//          <li>
//              <a id="mypage-navbar-toggle">Close <i class="fa fa-bars menu-icon fa-2x" aria-hidden="true"></i></a>
//          </li>
//          <li>
//              <a href="#">Home <i class="fa fa-home menu-icon fa-2x" aria-hidden="true"></i></a>
//          </li>
//          <li>
//              <a href="#">Download<i class="fa fa-download menu-icon fa-2x" aria-hidden="true"></i></a>
//          </li>
//          <li>
//              <a href="#">Edit<i class="fa fa-cog menu-icon fa-2x" aria-hidden="true"></i></a>
//          </li>
//          <li>
//              <a href="#">log out<i class="fa fa-sign-out menu-icon fa-2x" aria-hidden="true"></i>
//                  </a>
//          </li>
//      </ul>
 </div>
	
	
	
	
	
	
	</script>