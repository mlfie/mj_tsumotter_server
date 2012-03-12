class CreateYakus < ActiveRecord::Migration
  def change
    create_table :yakus do |t|
      t.string :name
      t.integer :han_num
      t.integer :naki_han_num

      t.timestamps
    end
  end
end
