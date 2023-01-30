class CreateExchangeRates < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_rates do |t|
      t.references :base, null: false
      t.references :quote,null: false
      t.integer :conversion_rate
      t.datetime :date

      t.timestamps
    end

    add_foreign_key :exchange_rates, :currencies,
                    column: :base_id, primary_key: :id
    add_foreign_key :exchange_rates, :currencies,
                    column: :quote_id, primary_key: :id
  end
end
