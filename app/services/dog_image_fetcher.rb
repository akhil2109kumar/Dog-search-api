class DogImageFetcher
  def self.fetch_dog_image_by_breed(breed)
    response = RestClient.get("#{ENV["DOG_IMAGE_FETCHER"]}#{breed}/images/random")
    handle_response(response)
  end

  private

  def self.handle_response(response)
    JSON.parse(response)
  end
end

