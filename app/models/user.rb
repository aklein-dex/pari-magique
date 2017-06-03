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

end
