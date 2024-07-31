class CreateAlerts < ActiveRecord::Migration[6.1]
  def change
    create_table :alerts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :cryptocurrency, null: false
      t.decimal :target_price, null: false
      t.string :status, null: false, default: 'created'

      t.timestamps
    end
  end
end
