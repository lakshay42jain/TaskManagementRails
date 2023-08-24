class UserService
  def deactivate_user(email)
    user_want_to_delete = User.find_by(email: email)
    if user_want_to_delete  
      user_want_to_delete.update!(active: false)
      { status: :ok }
    else  
      { message: 'User Not Found' }
    end  
  end

  def find_all
    users = User.all
    # if users.empty?
    #   { message: 'Users not found' }
    # else
    #   { status: :ok }
    #   users
    # end  
  end
end
