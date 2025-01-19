class AddCaseInsensitiveIndexToEmailOnUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext' if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end
  end
end
