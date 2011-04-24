Feature: Include the root (and only the root) in the JSON
  
  Scenario: Including the root in the JSON, but not adding roots to any child elements
    Given that "/books/2001-space-odyssey.json" returns:
      """
      {
        "title": "2001: A Space Odyssey",
        "id": "2001-space-odyssey",
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
      """
    When I retrieve the book via ActiveResource
    And I change the author to "Arthur C. Clarke"
    And I save the book
    Then ActiveResource should send the following back to the server:
      """
      {
        "book": {
          "author": "Arthur C. Clarke",
          "title": "2001: A Space Odyssey",
          "id": "2001-space-odyssey",
          "genres": [
            {
              "name": "Fiction",
              "id": "fiction"
            },
            {
              "name": "Science Fiction",
              "id": "science-fiction"
            }
          ]
        }
      }
      """
