class Response < ApplicationRecord
  validates :keyword, uniqueness: { case_sensitive: false }
  validates :keyword, uniqueness: { scope: :reply, message: 'and reply are invalid' }
end
