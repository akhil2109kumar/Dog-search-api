class DogsController < ApplicationController

  def create
    dog = find_or_create_dog
    if dog.present?
      render json: { breed: dog.breed, image_url: dog.image_url }
    else
      render json: { error: 'Dog breed not found' }, status: :unprocessable_entity
    end
  end

  private

  def dog_params
    params.require(:dog_form).permit(:breed, :image_url)
  end

  def find_or_create_dog
    if formatted_breed.present?
      dog = Dog.find_by(breed: formatted_breed)
      return dog if dog.present?
      create_dog_with_image
    end
  end

  def create_dog_with_image
    response = DogImageFetcher.fetch_dog_image_by_breed(formatted_breed)
    Dog.create(breed: formatted_breed, image_url: response['message']) if response['status'] == 'success'
  rescue RestClient::NotFound => e
    handle_error(e)
    nil
  end

  def handle_error(error)
    logger.error("Error fetching dog image: #{error.message}")
    error.response&.body || "Invalid Breed"
  end

  def formatted_breed
    format_breed(params[:dog_form][:breed])
  end

  def format_breed(breed)
    # Here formatting the breed name as i have seen in the sample api, that whenver someone enter any breed with space then it will split and reverese the word and add a '/' between them and then make the request to the respective api.
    breed.downcase.split(" ").reverse.join("/")
  end
end
