class DogsController < ApplicationController

  def create
    dog = find_or_initialize_dog
    if dog.save
      render json: { breed: dog.breed, image_url: dog.image_url }
    else
      render json: { error: 'Dog breed not found' }, status: :unprocessable_entity
    end
  end

  private

  def dog_params
    params.require(:dog_form).permit(:breed, :image_url)
  end

  def find_or_initialize_dog
    Dog.find_or_initialize_by(breed: formatted_breed) do |dog|
      dog.assign_attributes(dog_params)
      dog.image_url = DogImageFetcher.fetch_dog_image_by_breed(formatted_breed)
    end
  end

  def formatted_breed
    format_breed(params[:dog_form][:breed])
  end

  def format_breed(breed)
    breed.downcase.split(" ").reverse.join("/")
  end
end
