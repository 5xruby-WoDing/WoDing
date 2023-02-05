# frozen_string_literal: true

class Restaurant < ApplicationRecord
  acts_as_paranoid

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :title, presence: true
  validates :address, presence: true
  validates :tel, presence: true, format: {with: /\d[0-9]\)*\z/}
  validates :interval_time, presence: true
  validates :period_of_reservation, presence: true
  validates :period_of_reservation, presence: true

  belongs_to :manager
  has_many :seats, -> { order(title: :asc) }
  has_many :reservations
  has_many :opening_times, -> { order(closed_time: :asc) }
  has_many :off_days, -> { order(off_day: :desc) }
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags

  has_rich_text :content
  has_many_attached :images
  has_many_attached :menus

  Restaurant.all.with_rich_text_content_and_embeds

  def tag_list=(arr)
    return unless arr.present?

    self.tags = arr.split(',').reject(&:blank?).uniq.map do |tag|
      Tag.where(name: tag.strip).first_or_create!
    end
  end

  def tag_list
    tags.map(&:name).join(',')
  end

  def self.tagged_with(name)
    Tag.find_by!(name:).restaurants
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def slug_candidates
    [
      :title,
      [:title, :address]
    ]
  end

end
