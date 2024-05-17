class DogImageFetcher
  BASE_URL = 'https://dog.ceo/api/breed/'

  def self.fetch_dog_image_by_breed(breed)
    response = RestClient.get(BASE_URL + "#{breed}/images/random")
    handle_response(response)
  end

  private

  def self.handle_response(response)
    JSON.parse(response)
  end
end

