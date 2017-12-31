class UserAdminsController < ApplicationController
  before_action :set_user_admin, only: [:show, :edit, :update, :destroy]
  before_action :check_session_user, except: [:login, :process_login, :create, :new, :user_login] 
  layout 'welcome'

  def sign_out
    cookies[:authentication_token] = nil
    cookies.permanent[:authentication_token] = nil
    flash[:notice] = "Succesfully Signed Out" 
    redirect_to '/'
  end 
  def admin_homepage;  end
  def login; end 
  def user_login; end
  def process_login
    potential_user =  UserAdmin.find_by(username: params[:username])
    entered_password = params[:password]
    if potential_user.present?
       #Check entered password with salted value
       if entered_password.present? && potential_user.valid_password?(entered_password)
          if params[:remember].present?
            cookies.permanent[:authentication_token] = potential_user.password_token
          else
            cookies[:authentication_token] = potential_user.password_token
          end
          path_name = potential_user.user_type.eql?('admin') ? admin_login_path : user_homepage_path
          redirect_to path_name
        else
        flash[:danger] = entered_password.present? ? "Invalid Password" : "Enter a password" 

        end 
    else 
      flash[:danger] = "There is no Admin with username #{params[:username]}"
      redirect_to admin_login_path 
    end
  end  
  # GET /user_admins
  # GET /user_admins.json
  def index
    @user_admins = UserAdmin.all
  end

  # GET /user_admins/1
  # GET /user_admins/1.json
  def show
  end

  # GET /user_admins/new
  def new
    @user_admin = UserAdmin.new
    @hide_invite = session[:user].present?

  end

  # GET /user_admins/1/edit
  def edit
    @hide_invite = true
    @editable = true
  end

  # POST /user_admins
  # POST /user_admins.json

  #Will be the "Create Your Account"  Route
  def create
    user = user_admin_params
    invite_only = UserAdmin.find_by(username: 'invite_only') unless cookies[:authentication_token].present? || params[:user_type].eql?('normal')
    if (cookies[:authentication_token].present?) || (params[:user_type].eql?('normal')) || (invite_only.valid_password? params[:invite_password] )
      @user_admin = UserAdmin.new(username: user[:username], name: user[:name])
      @user_admin.encrypt_password(user[:password])
    end   
    if @user_admin.valid?
    respond_to do |format|
      if @user_admin.save
        flash[:notice] = "Congrats! User Account Created!"
        format.html { redirect_to admin_homepage_path, notice: 'Account Successfully Created!.' }
        format.json { render :show, status: :created, location: @user_admin }
      else
        format.html { render :new }
        format.json { render json: @user_admin.errors, status: :unprocessable_entity }
      end
    end
    else 
      if cookies[:authentication_token].nil?
      flash[:danger] = @user_admin.errors.full_messages.join(' <br>') || "Need an Invite Code to become an Admin. "
      redirect_to :back
      else 
      flash[:danger] = "One user already has an account name with username #{params[:user_admin][:username]}"
      redirect_to :back
        end 
      end
  end 

  # PATCH/PUT /user_admins/1
  # PATCH/PUT /user_admins/1.json
  def update
    respond_to do |format|
      new_password = params[:user_admin][:password] 
      password = new_password.present? ? @user_admin.encrypt_password(new_password) : @user_admin.password
      if @user_admin.update(user_admin_params.merge(password: password))
        format.html { redirect_to @user_admin, notice: 'User admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_admin }
      else
        format.html { render :edit }
        format.json { render json: @user_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_admins/1
  # DELETE /user_admins/1.json
  def destroy
    @user_admin.destroy
      respond_to do |format|
      format.html { redirect_to user_admins_url, notice: 'User admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_session_user
      auth_token = cookies[:authentication_token] || cookies.permanent[:authentication_token] || nil
      if auth_token.nil?
      flash[:notice] = "Admin Access Required. No User Logged In! Redirected to Login Page" unless flash[:notice].present?
      redirect_to admin_login_path 
      else 
        @user = UserAdmin.find_by(password_token: cookies[:authentication_token]) 
      end 
    end 
    # Use callbacks to share common setup or constraints between actions.
    def set_user_admin
      @user_admin = UserAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_admin_params
      params.require(:user_admin).permit(:name, :username, :password)
    end
end
