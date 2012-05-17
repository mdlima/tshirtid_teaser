# encoding: utf-8
# == Schema Information
#
# Table name: email_subscriptions
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  opt_in          :boolean
#  opt_in_campaign :string(255)
#  ip              :string(255)
#  last_opt_in     :datetime
#  last_opt_out    :datetime
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class EmailSubscription < ActiveRecord::Base
  validates_presence_of :email, :message => 'Por favor, preencha o seu email.'
  validates_uniqueness_of :email, :message => 'Seu email já está cadastrado, obrigado.'
  validates_format_of :email,
    :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    :message => 'Este email parece ser inválido.'
  
  attr_accessible :email, :ip, :last_opt_in, :last_opt_out, :name, :opt_in, :opt_in_campaign
  
  

end
