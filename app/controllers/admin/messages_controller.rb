class Admin::MessagesController < AdminController
  before_action :set_admin_message, only: [:show, :edit, :update, :destroy]

  # GET /admin/messages
  # GET /admin/messages.json
  def index
    target = nil
    if !params[:tag].nil?
      target = Admin::Tag.find_by_name(params[:tag])
    elsif !params[:category].nil?
      target = Admin::Category.find_by_name(params[:category])
    elsif !params[:user].nil?
      target = Admin::User.find_by_username(params[:user])
    else
      @admin_messages = Admin::Message.all.order("created_at DESC").paginate(:page=>params[:page],
              :per_page => 10)
    end
    @admin_messages = target.messages.order("created_at DESC").paginate(:page=>params[:page],
              :per_page => 10) if !target.nil?
  end

  # GET /admin/messages/1
  # GET /admin/messages/1.json
  def show
  end

  # GET /admin/messages/new
  def new
    @admin_message = Admin::Message.new
    @categories = Admin::Category.all
  end

  # GET /admin/messages/1/edit
  def edit
    message = Admin::Message.find_by_id(params[:id])
    @category = message.category if !message.nil?
    @categories = Admin::Category.all
  end

  # POST /admin/messages
  # POST /admin/messages.json
  def create
    prms = admin_message_params
    prms[:abstract] = prms[:content][0,100]
    @admin_message = Admin::Message.new(prms)
    respond_to do |format|
      if @admin_message.save
        tags = prms[:tag].split(",")
        if tags
          tags.each do |tagName|
            @admin_message.add_tag(tagName)
          end
        end
        @admin_message.add_category(prms[:category])
        format.html { redirect_to admin_messages_url, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @admin_message }
      else
        format.html { render :new }
        format.json { render json: @admin_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/messages/1
  # PATCH/PUT /admin/messages/1.json
  def update
    prms = admin_message_params
    @admin_message.remove_category
    prms[:abstract] = prms[:content].strip[0,10]
    respond_to do |format|
      if @admin_message.update(prms)
        tags = prms[:tag].split(",")
        if tags
          tags.each do |tagName|
            @admin_message.add_tag(tagName)
          end
        end

        @admin_message.add_category(prms[:category])
        format.html { redirect_to admin_messages_url, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_message }
      else
        format.html { render :edit }
        format.json { render json: @admin_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/messages/1
  # DELETE /admin/messages/1.json
  def destroy
    @admin_message.destroy
    respond_to do |format|
      format.html { redirect_to admin_messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def batch_destroy
    message_ids = params[:id].split(",").flatten
    if message_ids.nil?||message_ids.empty?
      respond_to do |format|
        format.html { redirect_to admin_messages_url,notice:'未选择用户！'}
        format.json { head :no_content }
      end
    else
      message_ids.each do |id|
        Admin::Message.find(id).destroy
      end
      respond_to do |format|
        format.html { redirect_to admin_messages_url,notice:'操作成功！'}
        format.json { head :no_content }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_message
      @admin_message = Admin::Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_message_params
      params.require(:admin_message).permit(:title, :content, :author, :tag, :category, :user_id)
    end

end
