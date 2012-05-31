class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.datetime :published_on

      t.timestamps
    end
  end
end
