class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.text :body
      t.integer :state, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :articles, :state
  end
end
