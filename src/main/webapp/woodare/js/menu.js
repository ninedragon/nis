$(function() {
			//管理员下拉
			$(".wapp-head .user").click(function(){
				$(this).next().show();
			});
			$(".wapp-head .lay").click(function(){
				$(this).hide();
			});
			
			//菜单选择
			$(".left-nav li.big-js").click(function(){
				$(".left-nav li.big-js").removeClass("on");
				$(this).addClass("on");
				$(".side-nav").hide();
				$(this).next().show();
			});
			$(".side-nav li").click(function(){
				$(".side-nav li").removeClass("on");
				$(this).addClass("on");
			});
			
			//菜单收缩
			$(".wapp-head span.link").click(function(){
				$(".left-nav").toggle();
				$(".wapp-head").toggleClass("long");
				$(".wapp-main").toggleClass("long");
				$(this).toggleClass("on");
			});
		});