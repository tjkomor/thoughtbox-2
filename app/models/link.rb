class Link < ActiveRecord::Base
  include ActiveModel::Validations
  validate :check_valid_link
  belongs_to :user
  validates :title, presence: true
  validates :url, presence: true

  def check_valid_link
    uri = URI.parse(self.url)
    self.errors.add(:base, "Please submit a valid URL") unless uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end
