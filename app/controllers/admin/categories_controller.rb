class Admin::CategoriesController < AdminController
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]
  before_action :handle_params,only: [:create,:update]
  before_action :get_super_path,only: [:index, :new]
  before_action :after_destroy_return_path, only: [:destroy,:batch_destroy]
  before_action :set_supcategory,only: [:index]
  # GET /admin/categories
  # GET /admin/categories.json
  def index
    if !@supcategory.nil?
      @admin_categories = @supcategory.subcategories
    else
      @admin_categories = Admin::Category.where(level:0)
    end
  end

  # GET /admin/categories/1
  # GET /admin/categories/1.json
  def show
  end

  # GET /admin/categories/new
  def new
    @admin_category = Admin::Category.new
    @categories = Admin::Category.all
  end

  # GET /admin/categories/1/edit
  def edit
    @father_id = Admin::Category.find(params[:id]).father_id
    @super_path = request.referer
    @categories = Admin::Category.all.where.not(id:@admin_category.id)
  end

  # POST /admin/categories
  # POST /admin/categories.json
  def create
    @admin_category = Admin::Category.new(handle_params)

    respond_to do |format|
      if @admin_category.save

        format.html { redirect_to return_path(@admin_category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @admin_category }
      else
        format.html { render :new }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/categories/1
  # PATCH/PUT /admin/categories/1.json
  def update

    respond_to do |format|
      if @admin_category.update(handle_params)
        format.html { redirect_to return_path(@admin_category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_category }
      else
        format.html { render :edit }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.json
  def destroy
    destroy_all_subs @admin_category.destroy
    respond_to do |format|
      format.html { redirect_to @return_path, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def batch_destroy
    category_ids = params[:id].split(",").flatten
    if category_ids.nil?||category_ids.empty?
      respond_to do |format|
        format.html { redirect_to admin_categories_url,notice:'未选择分类！'}
        format.json { head :no_content }
      end
    else
      category_ids.each do |id|
        destroy_all_subs Admin::Category.find(id).destroy
      end
      respond_to do |format|
        format.html { redirect_to @return_path,notice:'操作成功！'}
        format.json { head :no_content }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Admin::Category.find(params[:id])
    end
    def set_supcategory
      @supcategory = Admin::Category.find_by_id(params[:father_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_category_params
      params.require(:admin_category).permit(:name, :father_id)
    end

    def handle_params
      prms = admin_category_params
      if prms[:father_id].nil?||prms[:father_id]==""
        prms[:level] = 0
        max = get_level_max(prms[:father_id])
        prms[:weight] = max+1
      else
        prms[:level] = Admin::Category.find(prms[:father_id]).level+1
        max = get_level_max(prms[:father_id])
        prms[:weight] = max+1
      end
      prms
    end
    def get_super_path
      if params[:father_id].nil?||params[:father_id]=='' #顶级目录
        @super_path = admin_categories_path if params[:action]=="new"
      else
        @super_path = admin_categories_path
        @father_id = params[:father_id]
        grandpa_id = Admin::Category.find(@father_id).father_id
        @super_path+="?father_id=#{grandpa_id}" if !grandpa_id.nil?
      end
    end
    def get_level_max(id)
      max = 0
      if !id.nil? #非顶级目录
        temp = Admin::Category.where(father_id:id)
        if !temp.nil?
          temp.each do |i|
            max = i.weight>max ? i.weight : max
          end
        end
      else #顶级目录
        temp = Admin::Category.where(level:0)
        if !temp.nil?
          temp.each do |i|
            max = i.weight>max ? i.weight : max
          end
        end
      end
      return max
    end
    def destroy_all_subs(category)
      temp = []
      category.subcategories.each do |sub|
        temp.push(sub)
      end
      while !temp.empty?
        cur = temp.shift
        cur.subcategories.each do |sub|
          temp.push(sub)
        end
        cur.destroy
      end
    end
    def after_destroy_return_path
      ids = params[:id].split(",").flatten
      admin_category = Admin::Category.find(ids[0])
      @return_path = admin_categories_path+"/?father_id=#{admin_category.father_id}"
      @return_path = admin_categories_path if admin_category.level==1
    end
    def return_path(category)
      if category.supcategory.nil? #父级分类为顶级分类
        admin_categories_path
      else
        admin_categories_path+"/?father_id=#{category.father_id}"
      end
    end
end
