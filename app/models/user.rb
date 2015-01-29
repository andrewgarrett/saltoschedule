class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # attr_accessible :email, :password, :password_confirmation, :is_active
  has_many :equipments, :dependent => :delete_all ,autosave: true
  has_many :lessons, :dependent => :delete_all, autosave: true
end
