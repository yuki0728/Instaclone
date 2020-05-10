class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :web_site
      t.string :profile
      t.string :email
      t.string :email
      t.string :tel_number
      t.integer :sex
      t.string :password

      t.timestamps
    end
  end
end
