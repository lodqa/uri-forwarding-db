class AddUrlReplacementPatternForImageToMatchers < ActiveRecord::Migration[5.1]
  def change
    add_column :matchers, :url_replacement_pattern_for_image, :string, null: false, default: ''
  end
end
