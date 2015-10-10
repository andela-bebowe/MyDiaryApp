class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :status
      t.integer :age
      t.string :sex

      t.timestamps null: false
    end
  end
end
