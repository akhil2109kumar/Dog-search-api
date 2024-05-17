class DogsController < ApplicationController

  def create
    dog = find_or_initialize_dog
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

  def find_or_initialize_dog
    dog = Dog.find_by(breed: formatted_breed)
    return dog if dog.present?
    create_dog_with_image
  end

  def create_dog_with_image
    response = DogImageFetcher.fetch_dog_image_by_breed(formatted_breed)
    return unless response['status'] == 'success'

    Dog.create(breed: formatted_breed, image_url: response['message'])
  rescue RestClient::NotFound => e
    handle_error(e)
    nil
  end

  def handle_error(error)
    logger.error("Error fetching dog image: #{error.message}")
    raise ActiveRecord::Rollback, error.response&.body || "Invalid Breed"
  end

  def formatted_breed
    format_breed(params[:dog_form][:breed])
  end

  def format_breed(breed)
    breed.downcase.split(" ").reverse.join("/")
  end
end
