class CategoriesController < ApplicationController
  layout 'welcome'
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :check_session_user, except: :show
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @user  = UserAdmin.find_by(username: session[:user]) if session[:user].present?  
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    if @category.valid? 
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    else
      render :new 
    end 
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def check_session_user
      auth_token = cookies[:authentication_token] || cookies.permanent[:authentication_token] || nil
      if auth_token.nil?
      flash[:notice] = "Admin Access Required. No User Logged In! Redirected to Login Page" unless flash[:notice].present?
      redirect_to admin_login_path 
      else 
        @user = UserAdmin.find_by(password_token: cookies[:authentication_token]) 
      end 
    end 

    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:category_name)
    end
end
