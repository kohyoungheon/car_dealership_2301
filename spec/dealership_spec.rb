require 'rspec'
require './lib/car'
require './lib/dealership'

RSpec.describe Car do
  it "exists" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    expect(dealership).to be_a Dealership
  end

  it "has a name" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    expect(dealership.name).to eq("Acme Auto")
  end

  it "has an address" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    expect(dealership.address).to eq("123 Main Street")
  end

  it "can count the inventory" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    expect(dealership.inventory_count).to eq(0)
  end

  it "can add cars to inventory" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36)
    car_2 = Car.new("Toyota Prius", 1000, 48)
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    expect(dealership.inventory_count).to eq(2)
  end

  it "checks if inventory does not exist" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    expect(dealership.has_inventory?).to eq(false)
  end

  it "checks if inventory exists" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36)
    car_2 = Car.new("Toyota Prius", 1000, 48)
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    expect(dealership.has_inventory?).to eq(true)
  end

  it "returns all cars with same make" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36)
    car_2 = Car.new("Toyota Prius", 1000, 48)
    car_3 = Car.new("Toyota Tercel", 500, 48)
    car_4 = Car.new("Chevrolet Bronco", 1250, 24)
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    dealership.add_car(car_3)
    dealership.add_car(car_4)
    expect(dealership.cars_by_make("Toyota").length).to eq(2)
  end

  it "adds total value of all cars" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36)
    car_2 = Car.new("Toyota Prius", 1000, 48)
    car_3 = Car.new("Toyota Tercel", 500, 48)
    car_4 = Car.new("Chevrolet Bronco", 1250, 24)
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    dealership.add_car(car_3)
    dealership.add_car(car_4)
    expect(dealership.total_value).to eq(156000)
  end

  it "provides dealership details" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36)
    car_2 = Car.new("Toyota Prius", 1000, 48)
    car_3 = Car.new("Toyota Tercel", 500, 48)
    car_4 = Car.new("Chevrolet Bronco", 1250, 24)
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    dealership.add_car(car_3)
    dealership.add_car(car_4)
    expect(dealership.details).to eq("total_value" => 156000, "address" => "123 Main Street")
  end

  it "gives the average price" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36)
    car_2 = Car.new("Toyota Prius", 1000, 48)
    car_3 = Car.new("Toyota Tercel", 500, 48)
    car_4 = Car.new("Chevrolet Bronco", 1250, 24)
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    dealership.add_car(car_3)
    dealership.add_car(car_4)
    expect(dealership.average_price_of_car).to eq("39,000")
  end

  it "sorts cars by price" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36) #54,000
    car_2 = Car.new("Toyota Prius", 1000, 48) #48,000
    car_3 = Car.new("Toyota Tercel", 500, 48) #24,000
    car_4 = Car.new("Chevrolet Bronco", 1250, 24) #30,000 #order: tercel => bronco => prius +> mustang
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    dealership.add_car(car_3)
    dealership.add_car(car_4)
    expect(dealership.cars_sorted_by_price[0].model).to eq("Tercel")
    expect(dealership.cars_sorted_by_price[1].model).to eq("Bronco")
    expect(dealership.cars_sorted_by_price[2].model).to eq("Prius")
  end

  it "return inventory hash by make" do
    dealership = Dealership.new("Acme Auto", "123 Main Street")
    car_1 = Car.new("Ford Mustang", 1500, 36) #54,000
    car_2 = Car.new("Toyota Prius", 1000, 48) #48,000
    car_3 = Car.new("Toyota Tercel", 500, 48) #24,000
    car_4 = Car.new("Chevrolet Bronco", 1250, 24) #30,000 #order: tercel => bronco => prius +> mustang
    dealership.add_car(car_1)
    dealership.add_car(car_2)
    dealership.add_car(car_3)
    dealership.add_car(car_4)
    expect(dealership.inventory_hash["Toyota"].length).to eq(2)
    expect(dealership.inventory_hash["Ford"].length).to eq(1)
    expect(dealership.inventory_hash["Chevrolet"].length).to eq(1)
  end

end