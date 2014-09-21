function swipeFun(obj,sconObj,thirdObj,forObj){//对象分别为"slider","marCon","ul","li"
			/******焦点图*********/
		var isTouch=true;
		var isTouchone = true;
		obj.each(function(){
			var cont=sconObj.html();
			sconObj.html(cont+cont);
			var ul=sconObj.find(thirdObj);
			var li=sconObj.find(forObj);
			var len=li.length;
			var lWid=li.eq(0).width();
			sconObj.width(lWid*len);
			ul.width(lWid*len/2);
			obj.stop(false,true);
		});
		
		
		/********控制时间间隔**********/
		$("#g_rightbtn").click(function(){
			toright();
		})
		$("#g_leftbtn").click(function(){
			toleft();
		})
		//var inter=setInterval(toright,5000);
		var inter = null;
		
		function toright(){
			isTouch=false;
			obj.stop(false,true);
			var scr=obj.scrollLeft();
			scr=parseInt(scr/obj.width())*obj.width();
			if(scr>=sconObj.width()/2){
				obj.scrollLeft(0);
				scr=obj.width();
				obj.animate({"scrollLeft":scr},500,function(){
					isTouch=true;
			});
			}else{
				obj.animate({"scrollLeft":scr+obj.width()},500,function(){
					isTouch=true;
				});
			}		
		}
		function toleft(){
			isTouchone=false;
			obj.stop(false,true);
			var scr=obj.scrollLeft();
			//alert (scr);
			scr=parseInt(scr/obj.width())*obj.width();
			if(scr<=0){
				obj.scrollLeft(sconObj.width()/2);
				scr=obj.width();
				obj.animate({"scrollLeft":sconObj.width()/2 - obj.width()},500,function(){
					isTouchone=true;
				});
				//alert (scr);
			}else{
				obj.animate({"scrollLeft":scr-obj.width()},500,function(){
					isTouchone=true;
				});
			}		
		}
		/********控制时间间隔**********/
		
		
		/******************滑动焦点图事件******************/
		obj.swipes({
			inits:function(){
				var ow=obj.width();
				var mW=sconObj.width();
				return((obj.scrollLeft()%ow==0)?obj.scrollLeft():(parseInt(obj.scrollLeft()/ow))*ow);
				},
			scrollDis:this.inits,
			swipeLeft:function(dis,bol){
				var ow=obj.width();
				var that=this;
				var mW=sconObj.width();
				if(bol){
					obj.stop(false,true);
					if(dis>=20){
						if(this.scrollDis>=mW/2){
							obj.scrollLeft(0);
							this.scrollDis=ow;
							obj.animate({"scrollLeft":this.scrollDis},500,function(){
								that.scrollDis=obj.scrollLeft();
								var i=1;
								
								//if(inter==null) inter=setInterval(toright,5000);
							});
						}else{
							obj.animate({"scrollLeft":this.scrollDis+parseInt(ow)},200,function(){
								that.scrollDis=obj.scrollLeft();
								var i=parseInt(obj.scrollLeft()/obj.width());
								
								//if(inter==null) inter=setInterval(toright,5000);
							});
						}
						
						}else{
							obj.animate({"scrollLeft":this.scrollDis},200,function(){
								that.scrollDis=obj.scrollLeft();
								//if(inter==null) inter=setInterval(toright,5000);
							});
						}
						
				}else{				
					/*if(inter&&isTouch){
						clearInterval(inter);
						inter=null;
						that.scrollDis=obj.scrollLeft();
					}*/
					if(this.scrollDis>=mW/2){
						obj.scrollLeft(0);
						this.scrollDis=0;
					}
					obj.scrollLeft(this.scrollDis+dis);	
				}
			},
			swipeRight:function(dis,bol){
				var ow=obj.width();
				var that=this;
				var mW=sconObj.width();
				if(bol){
					if(dis>=20){
						obj.stop(false,true);
						if(this.scrollDis<=0){
							obj.scrollLeft(mW/2+ow);
							this.scrollDis=mW/2;
							
							obj.animate({"scrollLeft":this.scrollDis},500,function(){
								that.scrollDis=obj.scrollLeft();
								var i=1;
								
								//if(inter==null) inter=setInterval(toright,5000);

							});
							}else{
								obj.animate({"scrollLeft":this.scrollDis-ow},200,function(){
									
									
									that.scrollDis=obj.scrollLeft();
									
									
									//if(inter==null) inter=setInterval(toright,5000);
								});
							}
						
						}else{
							obj.animate({"scrollLeft":this.scrollDis},200,function(){
								that.scrollDis=obj.scrollLeft();
								//if(inter==null) inter=setInterval(toright,5000);
							});
						}
				}else{
					/*if(inter&&isTouch){
						clearInterval(inter);
						inter=null;
						that.scrollDis=obj.scrollLeft();
					}*/
					if(this.scrollDis<=0){
						obj.scrollLeft(mW/2);
						this.scrollDis=mW/2;
					}
					obj.scrollLeft(this.scrollDis-dis);
				}
			},
			preventDefaultEvents: true
		});
		/******************滑动焦点图事件end******************/
	}
		/*************焦点图结束****************/