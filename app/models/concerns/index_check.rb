module IndexCheck
  def index_check(index)
    if (index + 1) % 3 == 0 && index != 0
      true
    end
  end
end