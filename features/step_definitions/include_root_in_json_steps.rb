Given /^that "([^"]*)" returns:$/ do |path, json_get_body|
  @path = path
  ActiveResource::HttpMock.respond_to do |mock|
    mock.get @path, {}, json_get_body
  end
end

When /^I retrieve the book via ActiveResource$/ do
  class Book < ActiveResource::Base; self.site = 'http://www.example.com'; self.format = :json; end
  @book = Book.find "2001-space-odyssey"
end

When /^I change the author to "([^"]*)"$/ do |author|
  @book.author = author
end

When /^I save the book$/ do

end

Then /^ActiveResource should send the following back to the server:$/ do |book_body|
  book_body = book_body.gsub(/^\s+/, "").gsub("\n", "").gsub(": \"", ":\"").gsub(": {", ":{").gsub(": [", ":[")
  update_book      = ActiveResource::Request.new(:put, @path, book_body)
  updated_response = ActiveResource::Response.new("", 204, {"Location" => @path})
  ActiveResource::HttpMock.respond_to({update_book => updated_response})
  @book.save
  found = false
  ActiveResource::HttpMock.requests.each {|r| found = r.body == book_body }
  found.should be_true
end
