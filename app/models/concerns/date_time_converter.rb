module DateTimeConverter
  def friendly_date_time
    self.created_at.strftime("%b. %d, %Y at %I:%M %p")
  end
end