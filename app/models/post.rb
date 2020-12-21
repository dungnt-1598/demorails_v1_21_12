class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :tagetable
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags
  validates :body, length: { maximum: 10 }
  accepts_nested_attributes_for :tags
end
