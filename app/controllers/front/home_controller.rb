class Front::HomeController < FrontController
  def index
    @messages = Admin::Message.all.order("created_at DESC").paginate(:page=>params[:page],
            :per_page => 5)
  end
end
