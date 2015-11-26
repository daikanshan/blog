class Front::MessageController < FrontController
  def index
    title = params[:title]
    @message = Admin::Message.find_by_title(title)
  end
end
