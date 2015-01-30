module DateTimeValidation
  extend ActiveSupport::Concern
  def created_at_is_valid_datetime
    errors.add(:created_at, 'must be a valid datetime') if ((DateTime.parse(self.created_at.to_s) rescue ArgumentError) == ArgumentError || DateTime.parse(self.created_at.to_s) == "1970-01-01T00:00:00+00:00")
  end

  def updated_at_is_valid_datetime
  	errors.add(:updated_at, 'must be a valid datetime') if ((DateTime.parse(self.updated_at.to_s) rescue ArgumentError) == ArgumentError || DateTime.parse(self.updated_at.to_s) == "1970-01-01T00:00:00+00:00")
  end

  def ended_at_is_valid_datetime
  	errors.add(:ended_at, 'must be a valid datetime') if ((DateTime.parse(self.ended_at.to_s) rescue ArgumentError) == ArgumentError || DateTime.parse(self.ended_at.to_s) == "1970-01-01T00:00:00+00:00")
  end
end