# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Database creation
  ** We are using PostgresSQL
## APP Documentation

We have two crud method they are image creation and retrieval.

* create image

POST '/images'

{
  data: {
    image_url: **external url/path of image inside public folder
  }
}

* Retrieve image

GET '/images:id'

{
  data: {
    id: image_id
  }
}
* ...
