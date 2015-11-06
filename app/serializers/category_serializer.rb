# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  name_en       :string
#  description   :text
#  icon          :string
#  created_at    :datetime
#  updated_at    :datetime
#  category_type :integer
#  parent_id     :integer
#  name_es       :string
#
# Indexes
#
#  index_categories_on_parent_id  (parent_id)
#

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.name_en
  end
end
