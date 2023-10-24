class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, foriegn_key: true
      t.references :post, foriegn_key: true
      t.timestamps
    end
  end
end
