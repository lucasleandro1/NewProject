class AddUniqueIndexToUsersCpf < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :cpf, unique: true
  end
end
