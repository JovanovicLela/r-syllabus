class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  rolify
         
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
