class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table :dogs do |t|
      t.string :breed
      t.string :image_url

      t.timestamps
    end
  end
end
