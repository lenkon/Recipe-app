require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Jim',
      username: 'Jim',
      email: 'jim@gmail.com',
      password: '111111',
      password_confirmation: '111111'
    )
    @food = Food.create(
      name: 'Grape',
      measurement_unit: 'Kg',
      price: 9,
      quantity: 40,
      user_id: @user.id
    )
  end

  it 'food name should be present' do
    @food.name = nil
    expect(@food).to_not be_valid
  end

  it 'food quantity should be >= 0' do
    @food.quantity = -5
    expect(@food).to_not be_valid
  end

  it 'quantity should be numeric' do
    @food.quantity = 'One'
    expect(@food).to_not be_valid
  end

  it 'food price should be >= 0' do
    @food.price = -4
    expect(@food).to_not be_valid
  end

  it 'food price  should be numeric' do
    @food.price = 'One'
    expect(@food).to_not be_valid
  end
end
