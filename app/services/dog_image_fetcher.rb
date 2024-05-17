class DogImageFetcher
  BASE_URL = 'https://dog.ceo/api/breed/'

  def self.fetch_dog_image_by_breed(breed)
    response = RestClient.get(BASE_URL + "#{breed}/images/random")
    handle_response(response)
  rescue RestClient::NotFound => e
    ActiveRecord::Base.transaction do

    error_message = e.response&.body || "Invalid Breed"
    JSON.parse(error_message)['message']
    handle_error("Dog breed not found: #{JSON.parse(error_message)['message']}")
    raise ActiveRecord::Rollback
    end
  rescue RestClient::ExceptionWithResponse => e
    handle_error("Dog API request failed: #{e.response.body}")
  rescue StandardError => e
    handle_error("Error while fetching dog image: #{e.message}")
  end

  private

  def self.handle_response(response)
    if response.code == 200
      JSON.parse(response.body)['message']
    end
  end

  def self.handle_error(message)
    Rails.logger.error(message)
  end
end

