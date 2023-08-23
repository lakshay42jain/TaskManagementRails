class UserService
  def deactivate_user(auth_token, email)
    user = User.find_by(auth_token: auth_token)
    if user&.role.eql?("admin")
      user_want_to_delete = User.find_by(email: email)
      if user_want_to_delete
        user_want_to_delete.active = false
        user_want_to_delete.save
        { status: :ok }
      else  
        { message: 'User Not Found' }
      end
    else 
      { message: 'Only Admin can deactivate the user' }
    end  
  end
end
