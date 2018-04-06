class ChangeColumnNameOfMatchers < ActiveRecord::Migration[5.1]
  def change
    rename_column :matchers, :xpath_to_image, :xpath_to_media
    rename_column :matchers, :url_replacement_pattern_for_image, :url_replacement_pattern_for_media
  end
end
