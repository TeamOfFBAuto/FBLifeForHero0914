$(document).ready(function(){

	
	//返回顶部
//	$("#w_hidnav").scroll(
//		function(){//控制隐藏显示
//			if($("#w_hidnav").scrollTop()>200){
//				$("#gotop").show();
//			}else{
//				$("#gotop").hide();
//			}
//		}
//	);
//	$("#gotop").click(function(){//控制返回顶部
//	$("#w_hidnav").animate({scrollTop:0},0);
//		return false;
//	}); 
	
	//临时调试
	//$("#weibo_pl").load(function(){
		//$(window).scrollTop($("#weibo_pl").offset().top);
	//});
	

	
	/**
	 * 返回顶部处理
	 */
	var _objscroll = {
		win:$(window),	
		doc:$(document),	
		gotopdiv:$('#gotop')	
	};
 	
	_objscroll.win.scroll(function(){
		if(_objscroll.win.scrollTop() > _objscroll.win.height()){
			_objscroll.gotopdiv.show();
		}else{
			_objscroll.gotopdiv.hide();
		}
		
	});
	
	//返回顶部点击
	_objscroll.gotopdiv.click(function(){//控制返回顶部
		_objscroll.win.scrollTop(0);
		return false;
		
	}); 
	
	

	
});