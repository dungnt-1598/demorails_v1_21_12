class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :tagetable
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
end
