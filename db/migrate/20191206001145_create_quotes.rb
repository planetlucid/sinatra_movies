class CreateQuotes < ActiveRecord::Migration[6.0]
    def change
      create_table :quotes do |t|
      t.string :author
      t.string :body
    end
  end
end
