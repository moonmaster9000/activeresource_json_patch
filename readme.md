# ActiveResource JSON Patch
  
Why? Because the ActiveResource (Rails 3) JSON format is broken, and this gem will fix it until ActiveResource gets patched. 

## The problem

Imagine you fetch a book over ActiveResource. 

    @book = Book.find '2001-space-odyssey'

The JSON that came to you looked like this: 

    {
      "title": "2001: A Space Odyssey",
      "id": "2001-space-odyseey",
      "genres": [
        {
          "name": "Fiction",
          "id": "fiction"
        },
        {
          "name": "Science Fiction",
          "id": "science-fiction"
        }
      ],
      "author": nil
    }

So far, so good. 

Now, let's update the author attribute and save it. 

    @book.author = "Arthur C. Clarke"
    @book.save

Great! But wait, let's inspect the JSON that it sent to the server on save:

    {
      "book": {
        "title": "2001: A Space Odyssey",
        "id": "2001-space-odyseey",
        "genres": [
          {
            "genre": {
              "name": "Fiction",
              "id": "fiction"
            }
          },
          {
            "genre": {
              "name": "Science Fiction",
              "id": "science-fiction"
            }
          }
        ],
        "author": "Arthur C. Clarke"
      }
    }

Not cool! By default, `ActiveResource::Base.include_root_in_json` is `true` - which is fine. Except it doesn't just include the `"book"` root, it added `"genre"` roots 
to all of the `"genres"`! This will completely fuck up your document. 

## The Solution

Step 1: Install this gem, `activeresource_json_patch`: either add it to your `Gemfile` and `bundle install`, or simply `gem install activeresource_json_patch`

Step 2: Require it in your codebase. If you included this in a Rails project via a `Gemfile`, then you're good to go. Otherwise, `require activeresource_json_patch` somewhere in your code.

Now, with the gem installed and loaded, were you to repeat the above steps, the JSON it will would send back would not inlude the superfluous `"genre"` roots:

    {
      "book": {
        "title": "2001: A Space Odyssey",
        "id": "2001-space-odyseey",
        "genres": [
          {
            "name": "Fiction",
            "id": "fiction"
          },
          {
            "name": "Science Fiction",
            "id": "science-fiction"
          }
        ],
        "author": "Arthur C. Clarke"
      }
    }

## LICENSE

None. This is PUBLIC DOMAIN. Do ANYTHING!
