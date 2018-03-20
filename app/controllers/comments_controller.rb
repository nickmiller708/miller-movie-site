class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_session_user, only: [:destroy]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render :back, status: :created, location: @comment }
      else
        format.html { render :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if @user.present? && @comment.review_post.user_admin.eql?(@user)
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to :back, notice: "Can't delete comments unless you are the author of the post" 
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def check_session_user
      auth_token = cookies[:authentication_token] || cookies.permanent[:authentication_token] || nil
      if auth_token.nil?
        flash[:notice] = "Admin Access Required. No User Logged In! Redirected to Login Page" unless flash[:notice].present?
        redirect_to admin_login_path 
      else 
        @user = UserAdmin.find_by(password_token: cookies[:authentication_token]) 
      end 
    end 
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :comment, :review_post_id)    
    end
end
