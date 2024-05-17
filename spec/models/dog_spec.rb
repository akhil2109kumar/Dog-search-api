require 'rails_helper'

RSpec.describe Dog, type: :model do
  it 'is valid with valid attributes' do
    dog = Dog.new(breed: 'labrador', image_url: 'https://images.dog.ceo/breeds/labrador/n02099712_1164.jpg')
    expect(dog).to be_valid
  end

  it 'is invalid without a breed' do
    dog = Dog.new(image_url: 'https://images.dog.ceo/breeds/labrador/n02099712_1164.jpg')
    expect(dog).not_to be_valid
  end

  it 'is invalid without an image_url' do
    dog = Dog.new(breed: 'Labrador')
    expect(dog).not_to be_valid
  end
end
