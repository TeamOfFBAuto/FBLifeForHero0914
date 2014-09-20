$(document).ready(function(){
	/******焦点图*********/
	var obj=$(".slider");
	try{
	obj.each(function(){
		var scontObj=$(this).find(".marCon");
		swipeFun($(this),scontObj,"ul","li");
	});
	
	
	//参数分别为第一个div，第二个滚动div，滚动里面的div，第三个里面的div
	
	}catch(e){
	
	}
	
	/*var no_li = $(".no_topcon").find("li").eq(0);
	$(".no_diposi").css("height",$(document).height() - no_li.find(".no_data").height() - no_li.find(".no_richeng").height() - 12);
	$(window).resize(function(){
		$(".no_diposi").css("height",$(document).height() - no_li.find(".no_data").height() - no_li.find(".no_richeng").height() - 12);
	});*/
});