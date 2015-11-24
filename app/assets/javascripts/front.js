// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
$(document).on('page:change',function(){
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
})
