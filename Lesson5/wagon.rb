class Wagon

end

class PassengerWagon < Wagon
  def type
    "passenger"
  end
end

class CargoWagon < Wagon
  def type
    "cargo"
  end
end
