class ContactMe < ApplicationMailer

  def contact_me(params)
    @sender = params[:send_name] || "Name not given :("
    @sender_email = params[:contact_email]
    @message = params[:message]
    mail(to: 'nickmiller708@gmail.com', from: 'millerhonestreview@gmail.com', subject: "New Message from #{@sender}")
  end

  def sender_copy(params)
    @sender = params[:send_name] || "Name not given :("
    @sender_email = params[:contact_email]
    @message = params[:message]
    mail(to: @sender_email, from: 'millerhonestreview@gmail.com', subject: "Sender Copy: New Message from #{@sender}")
  end  
  def reset_password(user)
    user.generate_token(:reset_token) 
    user.save
    @user = user 
    contact_email = user.email 
     mail(to: contact_email, from: 'millerhonestreview@gmail.com', subject: "Reset Your Password")
  end 
end
