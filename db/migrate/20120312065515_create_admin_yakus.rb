class CreateAdminYakus < ActiveRecord::Migration
  def change
    create_table :admin_yakus do |t|
      t.string :name
      t.integer :han_num
      t.integer :naki_han_num

      t.timestamps
    end

    drop_table :yakus
  end
end
