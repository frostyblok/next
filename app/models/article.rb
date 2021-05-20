class Article < ApplicationRecord
  belongs_to :user

  enum state: [:draft, :published]
end
