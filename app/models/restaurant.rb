class Restaurant < ApplicationRecord
  acts_as_paranoid

  validates :title, presence: true
  validates :address, presence: true
  validates :tel, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :manager
  has_many :seats
  has_many :reservations
  has_many_attached :images
  
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags

  def tag_list=(arr)
    self.tags = arr.strip.gsub(/\s+?[\s\/\,\，]\Z/, '').split(/[\s\/\,\，][\s]?/).map do |tag|
      Tag.where(name: tag.strip).first_or_create!
    end
  end

  def tag_list
    tags.map(&:name).join('/')
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).restaurants
  end




end
