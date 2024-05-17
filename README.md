# Dog Image Fetcher Service

This is a simple application that allows users to fetch random dog images associated with specific breeds. It consists of a Ruby on Rails backend for handling dog creation requests and a DogImageFetcher service for fetching dog images from a Dog API. Additionally, there is a React application for viewing and interacting with the dog images.

## Features

- **Dog Creation:** Users can submit a dog breed, and the application fetches a dog image associated with that breed using the DogImageFetcher service.

- **Search Dog During Creation:** Users can submit a dog breed, and the application searches for the dog with breed and if it exists in the database then it fetches dog image associated with that breed from the database.

- **Error Handling:** The application gracefully handles errors during the Dog API request and form submission.

- **React Application:** The React application provides a simple form for users to submit a dog breed and view the associated random dog image.


**Endpoint**
Endpoint: /dogs
Purpose: Retrieve an image of dog with associated breed which is entered by the user.
Parameters:
breed: Specifies the breed for fetching the image of that breed's dog.
Response: Returns an image url containing the path of the image of that breed which is available.

# TOOLS USED
* Rspecs: for test cases.
* Ruby (3.2.2): for the core language of Rails framework.
* Rails (7.0.8): Web application framework build in ruby programming language.
* Sqlite3 Database Used

## Rails Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/akhil2109kumar/dog-image-fetcher.git
   cd dog-image-fetcher
   ```
2. **Install Dependencies:**
* Ruby version
  3.0.0

* Rails version
  7.0.8

* Please Copy application.yml.sample in application.yml =>
  ```
  copied config/application.yml.sample will  become config/application.yml
  ```

* For installing all the gems required/used =>
  ```
  bundle install
  ```
* For create the database =>
  ```
  rake db:create
  ```
  
* For running the migration =>
  ```
  rake db:migrate
  ```

* To start the server =>
  ```
  rails server -p 3001
  ```

* To run the rspecs/test cases =>
  ```
  rspec
  ```

