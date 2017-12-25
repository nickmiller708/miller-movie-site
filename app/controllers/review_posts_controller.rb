class ReviewPostsController < ApplicationController
  before_action :set_review_post, only: [:show, :edit, :update, :destroy]
  before_action :check_session_user, except: :show
  layout 'welcome'
  # GET /review_posts
  # GET /review_posts.json
  def index
    @review_posts = ReviewPost.all
  end

  # GET /review_posts/1
  # GET /review_posts/1.json
  def show
    @user  = UserAdmin.find_by(username: session[:user]) if session[:user].present?  
    @editable = @review_post.user_admin == @user 
    @comment = Comment.new
    @relevant_link = RelevantLink.new 
  end

  # GET /review_posts/new
  def new
    @review_post = ReviewPost.new
  end

  # GET /review_posts/1/edit
  def edit
  end

  # POST /review_posts
  # POST /review_posts.json
  def create
    @review_post = ReviewPost.new(review_post_params)
    respond_to do |format|
      if @review_post.save
        format.html { redirect_to @review_post, notice: 'Review post was successfully created.' }
        format.json { render :show, status: :created, location: @review_post }
      else
        format.html { render :new }
        format.json { render json: @review_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /review_posts/1
  # PATCH/PUT /review_posts/1.json
  def update
    respond_to do |format|
      if @review_post.update(review_post_params)
        format.html { redirect_to @review_post, notice: 'Review post was successfully updated.' }
        format.json { render :show, status: :ok, location: @review_post }
      else
        format.html { render :edit }
        format.json { render json: @review_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /review_posts/1
  # DELETE /review_posts/1.json
  def destroy
    @review_post.destroy
    respond_to do |format|
      format.html { redirect_to review_posts_url, notice: 'Review post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_session_user
      if session[:user].nil?
      flash[:notice] = "Admin Access Required. No User Logged In! Redirected to Login Page" unless flash[:notice].present?
      redirect_to admin_login_path 
      else 
        @user = UserAdmin.find_by(username: session[:user]) 
      end 
    end 
    # Use callbacks to share common setup or constraints between actions.
    def set_review_post
      @review_post = ReviewPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_post_params
      params.require(:review_post).permit(:user_admin_id, :category_id, :contents, :title)

    end
end
