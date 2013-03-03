class User < ActiveRecord::Base
  has_many :reservations
  has_many :rooms, :through => :reservations
  has_one :profile, :dependent => :destroy
  has_many :check_ins, :dependent => :destroy
  acts_as_api
  
  api_accessible :profiles_with_user  do |t| 
    t.add :name
    t.add :check_ins
  end


  # Include default devise modules. Others available are:
  #  :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable 
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :profile_attributes, :current_password
  attr_accessible :role, :as => :admin
  before_create :setup_default_role_for_new_users
  ROLES = %w[admin default banned]
  after_create :create_child
  accepts_nested_attributes_for :profile
  validates_associated :profile
  
  
  def admin?
    true if self.role == "admin"
  end
  
  private
  
  def setup_default_role_for_new_users
    if self.role.blank?
      self.role = "default"
    end
  end

  def last_checkin
    self.check_ins.last
  end

  def create_child
    Profile.create("user_id" => id)
  end
end
