class Admin::UsersController < AdminController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @admin_users = Admin::User.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @admin_user = Admin::User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @admin_user = Admin::User.new(admin_user_params)

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to @admin_user, notice: "用户<#{@admin_user.username}>创建成功！" }
        format.json { render :show, status: :created, location: @admin_user }
      else
        format.html { render :new }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to @admin_user, notice: "用户<#{@admin_user.username}>更新成功！" }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    begin
      @admin_user.destroy
      flash[:notice] = "用户 #{@admin_user.name} 已删除"
    rescue Exception => e
      flash[:notice] = e.message
      respond_to do |format|
        format.html { redirect_to admin_users_url,notice:e.message}
        format.json { head :no_content }
      end
      return
    end
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: "操作成功！" }
      format.json { head :no_content }
    end
  end

  def batch_destroy
    user_ids = params[:id].split(",").flatten
    if user_ids.nil?||user_ids.empty?
      respond_to do |format|
        format.html { redirect_to admin_users_url,notice:'未选择用户！'}
        format.json { head :no_content }
      end
    else
      user_ids.each do |id|
        @admin_user = Admin::User.find(id)
        self.destroy
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:admin_user).permit(:username, :realname, :password, :password_confirmation, :email)
    end
end
