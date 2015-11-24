class AdminController < ApplicationController
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
end
