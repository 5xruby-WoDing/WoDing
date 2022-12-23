# frozen_string_literal: true

class Restaurant < ApplicationRecord
  acts_as_paranoid

  validates :title, presence: true
  validates :address, presence: true
  validates :tel, presence: true

  belongs_to :manager
  has_many :seats
  has_many :reservations
  has_many :opening_times
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags

  has_many_attached :images
  has_rich_text :content

  Restaurant.all.with_rich_text_content_and_embeds

  def tag_list=(arr)
    self.tags = arr.split(',').map do |tag|
      Tag.where(name: tag.strip).first_or_create!
    end
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def self.tagged_with(name)
    Tag.find_by!(name:).restaurants
  end
end
