class Dealership
  attr_reader :name, :address, :inventory
  def initialize(name,address)
    @name = name
    @address = address
    @inventory = []
    @total_value = 0
  end

  def inventory_count
    @inventory.count()
  end

  def add_car(car)
    @inventory << car
  end

  def has_inventory?
    if @inventory.length > 0
      true
    else
      false
    end
  end

  def cars_by_make(make)
    same_make_cars = []
    @inventory.each do |car|
      if car.make == make
        same_make_cars << car
      end
    end
    same_make_cars
  end

  def total_value
    @inventory.each do |car|
      @total_value += car.total_cost
    end
    @total_value
  end

  def details
    self.total_value
    details_hash = {"total_value" => @total_value, "address" => @address}
  end

  def average_price_of_car
    total = self.total_value
    average = total / @inventory.length()
    average = average.to_s
    #add commas to number
    average.reverse.scan(/\d{3}|.+/).join(",").reverse
  end

  def cars_sorted_by_price
    sorted = @inventory.sort_by{|car| car.total_cost}
    sorted
  end

  def inventory_hash
    makes_hash = Hash.new
    makes_array = []
    @inventory.each{|car|makes_array << car.make}
    uniq_makes = makes_array.uniq
    uniq_makes.each{|make|makes_hash[make]=[]}
    @inventory.each do |car|
      makes_hash[car.make] << car
    end
    makes_hash
  end
end