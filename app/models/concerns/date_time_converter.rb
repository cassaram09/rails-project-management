module DateTimeConverter
  def friendly_created_at
    self.created_at.strftime("%b. %d, %Y at %I:%M %p")
  end
end