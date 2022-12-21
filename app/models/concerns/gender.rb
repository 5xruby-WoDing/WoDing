# frozen_string_literal: true

module Gender
  extend ActiveSupport::Concern
  included do
    enum gender: %i[先生 小姐 其他]
  end
end
