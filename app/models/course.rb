class Course < ApplicationRecord
  validates :title,  presence: true
  validates :description, presence: true, length: { :minimum => 5 }
  
  
  # extend FriendlyId
  # friendly_id :title, use: [:slugged, :finders]
  
  
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :enrollments
  
  def to_s
    title
  end
  has_rich_text :description
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  def bought(user)
    # if the current user does not have enrollment for the current course id, then the user can buy this course
    # connected with buy_course in user.rb
    self.enrollments.where(user_id: [user.id], course_id: [self.id].empty?)
  end

end
