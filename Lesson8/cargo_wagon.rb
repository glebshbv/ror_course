class CargoWagon < Wagon

  attr_reader :total_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @occupied_volume = 0
  end

  def reserve_volume(volume)
    raise StandardError, "No more available volume" if @occupied_volume + volume > @total_volume
    @occupied_volume += volume
  end

  def occupied_volume
    @occupied_volume
  end

  def available_volume
    @total_volume - @occupied_volume
  end

  def type
    "cargo"
  end
end
