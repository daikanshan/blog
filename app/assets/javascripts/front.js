// = require jquery
// = require jquery_ujs

// = require bootstrap-sprockets
// = require ckeditor/init
// $(document).on('page:change',function(){
$(document).ready(function(){
  $("ul.subnav").each(function(){
    //控制子菜单宽度
    var width = 0;
    $(this).children("li").each(function(){
      width+=$(this).width();
    })
    $(this).css("width",width);
    //
    var index = 0;
    $(this).children("li").each(function(){
      $(this).children("ul.subnav").css("left",$(this).width()*index);
      index++;
    })
  })
  $("ul.topnav li").mouseover(function() {
      $(this).children("ul.subnav").stop(true).slideDown("fast");
      $(this).hover(function() {
      }, function() {
          //When the mouse hovers out of the submenu1, move it back up
          $(this).parent().find("ul.subnav").stop(true).slideUp("fast");
      });
  }).hover(function() {
      $(this).addClass("hover");
  }, function() {
      $(this).removeClass("hover");
  });
  $("ul.subnav li").hover(function() {
      $(this).find("ul.subnav:first").stop(true).slideDown("fast");
  }, function() {
      $(this).find("ul.subnav:first").stop(true).slideUp("fast");

  });
  $('.logo').click(function(){
    if(!$('#navs').is(":visible")){
      $('#navs').animate({
        left:-$('#navs').width(),
      },0,function(){
        $('#navs').show("fast");
        $('#navs').animate({
          left:"0",
        },100)
      })
    }else{
      $('#navs').animate({
        left:-$('#navs').width(),
      },100,function(){
        $('#navs').hide("fast");
      })
    }
  })
//监听滚动事件
  // var dis = $("#nav-menu").offset().top;
  // var marginTop = $(".main").css("margin-top");
  // $(window).scroll(function(){
	// 	var height = $(window).scrollTop();
	// 	if(height>=dis){
	// 		$("#nav-menu").addClass("navbar-fixed-top");
	// 		$("#nav-menu").css("margin-top",0);//取消菜单的margin-top使其完全贴近顶部
  //     $(".main").css("margin-top","85px");
  //     //监听右下方快捷上滚
  //
	// 	}else{
	// 		$("#nav-menu").removeClass("navbar-fixed-top");
  //     $(".main").css("margin-top",marginTop);
	// 	}
  // });
  $(window).scroll(function(){
    var height = $(window).scrollTop();
    var dis = $(".main").offset().top;
    if(height>=dis){
      $(".upupup").show("slow");
    }else{
      $(".upupup").hide("slow");
    }
  })
  $('.upupup').click(function(){
    $("html,body").animate({scrollTop:"0"},1000)
  })

})
