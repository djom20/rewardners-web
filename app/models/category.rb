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

class Category < ActiveRecord::Base

  attr_accessor :category_id

  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id"

  validates :name_en, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true, allow_blank: true
  validates :icon, presence: true, allow_blank: true
  validates :category_type, presence: true, inclusion: 1..3
  validates :category_id, presence: true, allow_nil: true, allow_blank: true

  scope :root_categories, -> {
    where(parent_id: nil, category_type: [nil, 1])
  }

  scope :sub_categories, -> (level) {
    where(category_type: level)
  }

  def self.get_tree_structure
    get_tree_structure_ root_categories, []
  end

  def branch?
    return category_type == 1 ? true : false
  end

  def leaf?
    return category_type == 2 ? true : false
  end

  def name_formatted
    name_en.upcase
  end

  def has_subcategories?
    subcategories.count > 0
  end

  def subcategories_by_level(level)
    subcategories.where(category_type: level)
  end

  def name_I18n locale
    locale.present? ? eval("name_#{locale}") : name_en
  end

  private

  def self.get_tree_structure_ items, items_struct
    items.each do |item|
      unless item.subcategories.empty?
        items_struct << {
          id: item.id,
          name: item.name,
          sub_categories: self.get_tree_structure_(item.subcategories, [])
        }
      else
        items_struct << {
          id: item.id,
          name: item.name,
          sub_categories: []
        } if item.leaf?
      end
    end
    items_struct
  end

end
