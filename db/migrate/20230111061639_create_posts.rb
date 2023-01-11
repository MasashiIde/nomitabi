class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id,      null: false
      t.string  :shop_name,    null: false, default: ""
      t.text    :introduction, null: false, default: ""
      t.string  :shop_address, null: false, default: ""
      t.string  :shop_url

      t.timestamps
    end
  end
end
