class Admin::Yaku < ActiveRecord::Base
  def attributes
    {'name' => name,
     'han_num' => han_num,
     'naki_han_num' => naki_han_num
    }
  end
end
