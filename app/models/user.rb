class User < ApplicationRecord
  after_create :welcome_send, :create_cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_one :cart
  validates :name, format: { with: /[\w -']*/, message: 'Seules les lettres et les espaces sont autorisées' }
  # length: { in: 6..30, message: 'Le nom doit faire entre 6 et 30 caractères' }

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def after_database_authentication
    Cart.create(user: self) if cart.nil?
  end

  def create_cart
    Cart.create(user: self)
  end

  def self.admins
    User.where(admin: true).to_a
  end
end
