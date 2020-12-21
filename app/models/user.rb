class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]
  def avatar_thumbnail
    if  avatar.attached?
      avatar.variant(resize: '150x150!').processed
    else
      'default_profile.jpg'
    end
  end

  def like_by_post(post)
    likes.find_by tagetable: post
  end

  def liked_post?(post)
    likes.find_by(tagetable: post).present?
  end

  def like_by_comment(comment)
    likes.find_by tagetable: comment
  end

  def liked_comment?(comment)
    likes.find_by(tagetable: comment).present?
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg'), filename: 'default_profile.jpg',
                                                                                         content_type: 'image/jpg')
      )
    end
  end
end
