class UserService
  attr_accessor :errors

  def deactivate_user(email)
    user = User.find_by(email: email)
    if user && user&.active == false
      self.errors = 'User already deactivated'
      return
    elsif user
      user.update(active: false)
    else  
      self.errors = 'User not found'
    end  
  end

  def find_all
    User.all
  end
end
