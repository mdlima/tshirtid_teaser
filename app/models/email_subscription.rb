class EmailSubscription < ActiveRecord::Base
  validates_presence_of :email, :message => 'Por favor, preencha o seu email.'
  validates_uniqueness_of :email, :message => 'Seu email já está cadastrado, obrigado.'
  validates_format_of :email,
    :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    :message => 'Este email parece ser inválido.'
  
  attr_accessible :email, :ip, :last_opt_in, :last_opt_out, :name, :opt_in, :opt_in_campaign
  
  

end
