class CreateEmailSubscriptions < ActiveRecord::Migration
  def change
    create_table :email_subscriptions do |t|
      t.string :name
      t.string :email
      t.boolean :opt_in
      t.string :opt_in_campaign
      t.string :ip
      t.datetime :last_opt_in
      t.datetime :last_opt_out

      t.timestamps
    end
  end
end
