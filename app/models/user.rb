class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  
  rolify
  
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0,20]
        )
    end
    user
  end
         
  def to_s
    email
  end
  
  has_many :courses
  has_many :enrollments
  
  after_create :assign_default_role

  # def assign_default_role
  #   self.add_role(:student) if self.roles.blank?
  # end
  
  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:student) if self.roles.blank?
      self.add_role(:teacher) #if you want any user to be able to create own courses
    end
  end
  
  
  validate :must_have_a_role, on: :update
  
  def buy_course(course)
    self.enrollments.create(course: course, price: course.price)
  end
  

  private
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "User must have at least one role.")
    end
  end
  
  
  
  
end
