module UUID
  extend ActiveSupport::Concern

  included do
    before_create :generate_uuid
  end

  def generate_uuid
    self.id = SecureRandom.uuid
  end
end