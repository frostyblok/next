class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validate :acceptable_image
  validates :title, :description, :body, presence: true

  scope :search_article, ->(query:) { includes(:user).where(
    'lower(title) LIKE lower(:search) OR lower(description) LIKE lower(:search) OR lower(body) LIKE lower(:search)',
    search: "%#{query}%")
  }

  enum state: [:draft, :published]

  private

  def acceptable_image
    return unless image.attached?

    unless image.byte_size <= 3.megabyte
      errors.add(:image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPEG or PNG")
    end
  end
end
