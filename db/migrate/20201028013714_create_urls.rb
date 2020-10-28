class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls, id: false do |t|
      t.string :short_url, null: false
      t.string :original_url, null: false
      t.integer :stats, null: false, default: 0
      t.timestamps
    end

    add_index :urls, :short_url, unique: true
  end
end
