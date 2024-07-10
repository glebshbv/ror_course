class PassengerWagon < Wagon
  attr_reader :total_seats

  def initialize(total_seats)
    @total_seats = total_seats
    @occupied_seats = 0
  end

  def type
    "passenger"
  end

  def take_seat
    raise StandardError, "No more seats available" if @occupied_seats >= @total_seats
    @occupied_seats += 1
  end

  def occupied_seats
    @occupied_seats
  end

  def available_seats
    @total_seats - @occupied_seats
  end
end
