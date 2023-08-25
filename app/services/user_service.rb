class UserService
  attr_accessor :errors

  def deactivate_user(email)
    user_want_to_delete = User.find_by(email: email)
    if user_want_to_delete  
      user_want_to_delete.update!(active: false)
    else  
      self.errors = 'User Not Found'
    end  
  end

  def find_all
    users = User.all
  end

  def tasks(current_user)
    all_tasks = current_user.tasks.where.not(status: [3, 4])
  end
  
end
