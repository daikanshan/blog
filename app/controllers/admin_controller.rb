class AdminController < ApplicationController
  before_action :check_init
  before_action :set_nav
  before_action :check_login

  private
    def set_nav
      @navs = []
      raw = YAML.load(File.read('config/extra/admin_nav.yml'))["nav"]
      raw.each do |item|
        controller, action = item["path"].split('/')
        @navs << {text: item["text"], icon: item["icon"], options: {controller: 'admin/' + controller, action: action}}
      end
      @navs
    end

    def check_login
      if session[:user_id].nil?
        respond_to do |format|
          format.html { redirect_to admin_login_path}
          format.json { head :no_content }
        end
      end
    end

    def check_init
      if Admin::User.count==0
        Admin::User.create(username:'root',realname:'root',password:'123456',password_confirmation:'123456',email:'root@root.root')
      end
      if Admin::Category.count==0
        Admin::Category.create(name:'默认',code:"01",weight:1,level:0,father_id:0)
      end
    end

end
