class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_init
private
  def check_init
    if Admin::User.count==0
      Admin::User.create(username:'root',realname:'root',password:'123456',password_confirmation:'123456',email:'root@root.root')
    end
    if Admin::Category.count==0
      Admin::Category.create(name:'默认',weight:1,level:0,father_id:nil)
    end
    if Front::Nav.count==0
      Front::Nav.create(text:'首页',weight:1,level:0,user_id:Admin::User.first.id,url:"home/index",code:"01")
    end
  end
end
