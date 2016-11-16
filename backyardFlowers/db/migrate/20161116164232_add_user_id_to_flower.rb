class AddUserIdToFlower < ActiveRecord::Migration[5.0]
  def change
    # action     table    row       datatype
     add_column :flowers, :user_id, :integer
  end
end
