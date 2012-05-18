class CreateEmailSubscriptions < ActiveRecord::Migration
  def change
    create_table :email_subscriptions do |t|
      t.string :name
      t.string :email, :null => false
      t.boolean :opt_in, :default => true
      t.string :opt_in_campaign
      t.string :ip
      t.datetime :last_opt_in
      t.datetime :last_opt_out

      t.timestamps
    end
    
    # add_index(:email_subscriptions, :email, { :name => "email_subscriptions_email_index", :unique => true })
  end
end
