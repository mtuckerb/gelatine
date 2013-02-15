class User < ActiveRecord::Base
  has_many :reservations
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at
  attr_accessible :role, :as => :admin
  before_create :setup_default_role_for_new_users
  ROLES = %w[admin default banned]
  
  
  def admin?
    true if self.role == "admin"
  end
  
  private
  
  def setup_default_role_for_new_users
    if self.role.blank?
      self.role = "default"
    end
  end
  
end
