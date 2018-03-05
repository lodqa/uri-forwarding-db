class AddXpathToMatchers < ActiveRecord::Migration[5.1]
  def change
    add_column :matchers, :xpath_to_image, :string, null: false, default: ''
  end
end
