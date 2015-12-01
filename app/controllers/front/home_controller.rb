class Front::HomeController < FrontController
  def index
    @messages = Admin::Message.all.order("created_at DESC")
  end
end
