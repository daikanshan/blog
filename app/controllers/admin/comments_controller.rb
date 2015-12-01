class Admin::CommentsController < AdminController
  before_action :handle_params,only: [:update,:create]
  # GET /admin/comments
  # GET /admin/comments.json
  def index
    @admin_comments = Admin::Comment.all
  end

  # GET /admin/comments/1
  # GET /admin/comments/1.json
  def show
  end

  # GET /admin/comments/new
  def new
    @admin_comment = Admin::Comment.new
  end

  # GET /admin/comments/1/edit
  def edit
  end

  # POST /admin/comments
  # POST /admin/comments.json
  def create
    @admin_comment = Admin::Comment.new(handle_params)

    respond_to do |format|
      if @admin_comment.save
        format.html { redirect_to message_path(Admin::Message.find_by_id(handle_params[:message_id]).title), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @admin_comment }
      else
        format.html { render :new }
        format.json { render json: @admin_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/comments/1
  # PATCH/PUT /admin/comments/1.json
  def update
    respond_to do |format|
      if @admin_comment.update(admin_comment_params)
        format.html { redirect_to @admin_comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_comment }
      else
        format.html { render :edit }
        format.json { render json: @admin_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/comments/1
  # DELETE /admin/comments/1.json
  def destroy
    @admin_comment.destroy
    respond_to do |format|
      format.html { redirect_to admin_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_comment
      @admin_comment = Admin::Comment.find(params[:id])
    end
    def handle_params
      prms = {};
      prms[:visitname] = params[:username]
      prms[:message_id] = params[:message_id]
      prms[:email] = params[:email]
      prms[:content] = params[:content]
      prms
    end
end
