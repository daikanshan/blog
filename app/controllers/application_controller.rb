class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_init
  helper_method [:markdown]

  def check_login
    if session[:user_id].nil?
      respond_to do |format|
        format.html { redirect_to admin_login_path}
        format.json { head :no_content }
      end
    end
  end
  # Redcarpet
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join("-") do
        Pygments.highlight(code, :lexer => language)
      end
    end
  end

  protected

  # pygments.rb
  def markdown(text)
    renderer = HTMLwithPygments.new({
      :filter_html => true,
      :hard_wrap => true,
      :link_attributes => {:rel => 'external nofollow'}
    })

    options = {
      :autolink => true,
      :no_intra_emphasis => true,
      :fenced_code_blocks => true,
      :lax_html_blocks => true,
      :strikethrough => true,
      :superscript => true
    }

    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
private
  def check_init
    if Admin::User.count==0
      Admin::User.create(username:'root',realname:'root',password:'123456',password_confirmation:'123456',email:'root@root.root')
    end
    if Admin::Category.count==0
      Admin::Category.create(name:'默认',weight:1,level:0,father_id:nil)
    end
    if Front::Nav.count==0
      Front::Nav.create(text:'首页',weight:1,level:0,user_id:Admin::User.first.id,url:"/")
    end
  end
end
