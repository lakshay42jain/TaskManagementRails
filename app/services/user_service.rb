class UserService
  attr_accessor :errors

  def deactivate_user(email)
    user = User.find_by(email: email)
    if user && user&.active == false
      self.errors = 'User already deactivated'
      return
    elsif user
      unless user.update!(active: false)
        self.errors = 'user not deactivated'
      end
    else  
      self.errors = 'User not found'
    end  
  end

  def login(email, password)
    user = User.find_by(email: email)
    if user&.authenticate(password)
      unless user.active
        self.errors = 'user deactivated by admin'
        return 
      end
      user
    else
      self.errors = 'Invalid email and password'
    end 
  end


  def find_all
    User.all.to_a
  end
end
