class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.text :reply
      t.string :keyword

      t.timestamps
    end
  end
end
