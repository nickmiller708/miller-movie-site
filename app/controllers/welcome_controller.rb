require 'pry'
class WelcomeController < ApplicationController
  before_action :check_session_user

    # GET welcome
  def index
    @active="index" 
  end
    
  def resume
    @active="resume"
  end
    
  def contact_me
    @active="contact_me"
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    if params[:sent].present?
       mailer_errors = mailer_errors(params) 
       if mailer_errors.any?
         @notice = mailer_errors
        else 
      if params[:contact_email].present?
           ContactMe.contact_me(params).deliver_now!
           ContactMe.sender_copy(params).deliver_now! if params[:copy_me].present?
      else
        ContactMe.contact_me(params).deliver_now!
      end 
    end 
    flash[:notice] = "Emails sent"
    redirect_to contact_me_path 
   end
  end  
  private
   def mailer_errors(params)
   email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
 
   error_text = []
     error_text << "Invalid Email Address Given" if (params[:contact_email].present?) && (params[:contact_email] =~ email_regex).nil?
      error_text << "No contents entered in the message. Can't send that :(" if params[:message].nil?
    error_text
   end 

    def check_session_user
      auth_token = cookies[:authentication_token] || cookies.permanent[:authentication_token] || nil
      if auth_token.present?
        @user = UserAdmin.find_by(password_token: cookies[:authentication_token]) 
      end 
    end 
  end
