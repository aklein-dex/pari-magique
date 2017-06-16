class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:member, :manager, :admin]

  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }

  has_many :members
  has_many :leagues, :through => :members

  # For role inheritance. For example an admin can do everything that a manager can do.
  def role?(compare_to_role)
    read_attribute_before_type_cast(:role) >= User.roles[compare_to_role]
  end
end
