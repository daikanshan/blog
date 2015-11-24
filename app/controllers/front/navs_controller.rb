class Front::NavsController < FrontController
  before_action :set_front_nav, only: [:show, :edit, :update, :destroy]
  before_action :get_super_path, only: [:show, :new]
  # GET /front/navs
  # GET /front/navs.json
  def index
    @front_navs = Front::Nav.where(level:0)
  end

  # GET /front/navs/1
  # GET /front/navs/1.json
  def show
    supnav = Front::Nav.find_by_id(params[:id])
    @front_navs = supnav.subnavs

  end

  # GET /front/navs/new
  def new
    @supnav_id = params[:id]

    @front_nav = Front::Nav.new
    @navs = Front::Nav.all.order('code')
    if !@navs.nil?
      @navs.each do |nav|
        nav.text = "　"*nav.level+nav.text
      end
    end
  end

  # GET /front/navs/1/edit
  def edit
    @super_path = front_nav_path(Front::Nav.find_by_id(params[:id]))
    @navs = Front::Nav.all.order('code')
    if !@navs.nil?
      @navs.each do |nav|
        nav.text = "　"*nav.level+nav.text
      end
    end
  end

  # POST /front/navs
  # POST /front/navs.json
  def create

    prms = handle_params

    @front_nav = Front::Nav.new(prms)

    respond_to do |format|
      if @front_nav.save
        return_path = @front_nav.supnav
        return_path = front_navs_path if return_path.nil?
        format.html { redirect_to return_path, notice: 'Nav was successfully created.' }
        format.json { render :show, status: :created, location: @front_nav }
      else
        format.html { render :new }
        format.json { render json: @front_nav.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /front/navs/1
  # PATCH/PUT /front/navs/1.json
  def update
    prms = handle_params
    respond_to do |format|
      if @front_nav.update(prms)
        format.html { redirect_to @front_nav, notice: 'Nav was successfully updated.' }
        format.json { render :show, status: :ok, location: @front_nav }
      else
        format.html { render :edit }
        format.json { render json: @front_nav.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /front/navs/1
  # DELETE /front/navs/1.json
  def destroy
    @front_nav.destroy
    respond_to do |format|
      format.html { redirect_to front_navs_url, notice: 'Nav was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def batch_destroy
    nav_ids = params[:id].split(",").flatten
    if nav_ids.nil?||nav_ids.empty?
      respond_to do |format|
        format.html { redirect_to admin_navs_url,notice:'未选择分类！'}
        format.json { head :no_content }
      end
    else
      nav_ids.each do |id|
        Front::Nav.find(id).destroy
      end
      respond_to do |format|
        format.html { redirect_to front_navs_url,notice:'操作成功！'}
        format.json { head :no_content }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_front_nav
      @front_nav = Front::Nav.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def front_nav_params
      params.require(:front_nav).permit(:text, :url, :icon, :shown, :supnav_id,:id)
    end
    def handle_params
      prms = front_nav_params
      prms[:user_id] = session[:user_id]
      # prms[:url] = "front/index" if prms[:url]=="" || prms[:url].nil?
      supnav = Front::Nav.find_by_id(prms[:supnav_id])
      if !supnav #防止提交id不存在
        prms[:supnav_id] = nil
        prms[:level] = 0
        prms[:weight] = get_level_max(0)+1
        prms[:code] = prms[:level].to_s+prms[:weight].to_s
      else
        prms[:level] = supnav.level+1
        prms[:weight] = get_level_max(supnav.level+1)+1
        prms[:code] = supnav.code+prms[:level].to_s+prms[:weight].to_s
      end
      prms
    end
    def get_level_max(level)
      max = 0
      temp = Front::Nav.where(level:level)
      if !temp.nil?
        temp.each do |i|
          max = i.weight>max ? i.weight : max
        end
      end
      return max
    end
    def get_super_path
      supnav = Front::Nav.find_by_id(params[:id])
      if supnav.nil?#防止用户地址输入
        @super_path = front_navs_path
      else
        @super_path = front_nav_path(supnav.supnav.id) if supnav.level!=0 #二级以下目录无返回show
        @super_path = front_navs_path if supnav.level==0 #二级目录返回index
      end
    end
end
