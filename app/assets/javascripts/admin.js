//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
$(document).on('page:change',function(){
  $(".item_line").click(function(event){
    base_url = $(".quick_option").attr("base-url")+'/';
     //alert(base_url);
    // alert(event.target.nodeName);
    if(event.target.nodeName=="TD"){
      check_box = $(this).find(".p_checkbox");
      // 选中
      check_box.prop("checked",!check_box.prop("checked"));
    }

    delete_able = true;
    ids = new Array();
    $(".item_line").each(function(){
      current = $(this).find(".p_checkbox");
      if(current.prop("checked") == true){
        ids.push(current.attr("value"));
        delete_able = false;
      }
    });
    str = ids.join(",");
    $("#del").attr("href",base_url+str+"/batch_destroy");
    if(delete_able){
      $('#del').attr("disabled","disabled");
      $('#del').removeAttr("data-method");
      $("#del").removeAttr("href");
    }else{
      $('#del').attr("data-method","delete");
      $('#del').removeAttr("disabled");
    }
  });
});
