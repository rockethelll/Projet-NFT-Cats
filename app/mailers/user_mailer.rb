class UserMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def welcome_email(user)
    @user = user
    @url = 'https://awesomecatpics-development.herokuapp.com/'
    mail(to: @user.email, subject: 'Bienvenue sur AwesomeCatPics !')
  end

  def send_order(order)
    @order = order
    @user = order.user
    @order_items = order.order_items
    mail(to: @user.email, subject: 'Merci pour ta commande')
  end

  def order_recap_to_admin(order)
    @order = order
    @user = order.user
    @order_items = order.order_items
    User.admins.pluck(:email).each do |email_adress|
      mail(to: email_adress, subject: 'Nouvelle commande')
    end
  end
end
