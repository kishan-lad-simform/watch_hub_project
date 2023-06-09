class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  after_create :assign_default_role

  validates :password, length: { in: 8..20 }
  validates :email, uniqueness: true, presence: true
  validates_format_of :password, 
    with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x,
    message: "Give atleast one small and one capital letter, one special symbol and one digit. "

  validates :firstname, :lastname, format: { 
    with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }

  validates :contact, numericality: {
      only_integer: true
    }, 
    length: {
      is: 10
    }

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def admin?
    has_role?(:admin)
  end

  def normal_user?
    has_role?(:user)
  end
end
