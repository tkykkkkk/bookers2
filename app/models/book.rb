class Book < ApplicationRecord
belongs_to :user 
has_many :book_comments, dependent: :destroy
has_many :favorites, dependent: :destroy
has_one_attached :image 

validates :title, presence: true
validates :body, presence: true, length: { maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end 
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end 
  end 
  
end

