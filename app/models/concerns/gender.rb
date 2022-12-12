module Gender
  extend ActiveSupport::Concern
  included do
    enum gender: [:先生, :小姐, :其他]
  end
end