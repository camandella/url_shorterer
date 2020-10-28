class Url < ApplicationRecord
  self.primary_key = 'short_url'

  validates :original_url, :stats, presence: true
  validates :short_url, presence: true, uniqueness: true
end
