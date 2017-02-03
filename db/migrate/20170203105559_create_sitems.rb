class CreateSitems < ActiveRecord::Migration[5.0]
  def change
    create_table :sitems do |t|
      t.string :name
      t.boolean :done
      t.references :stodo, foreign_key: true

      t.timestamps
    end
  end
end
