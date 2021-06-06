require 'rails_helper'

describe 'Books Api', type: :request do
  describe "Gets Books" do 
    before do
      FactoryBot.create(:book, title: "Quijote", author: "Cervantes")
      FactoryBot.create(:book, title: "Planta", author: "Vasconcellos")
    end
    it 'returns all books' do
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST books" do 
    it 'create new book' do
      expect {
        post "/api/v1/books", params: {
          book: { title: "kllookk" }, 
          author: {first_name: "Cesar", last_name: "Rivera", age: 48 } 
        }
      }.to change(Book.all,:count).by(1)
      expect(response).to have_http_status(:created)
      expect(Author.count).to eql(1)
    end
    it "invalid values create new book" do
      expect {
        post "/api/v1/books", params: {
           book: {title: ""} ,
           author: {first_name: "", last_name: "", age: nil}
        }
      }.not_to change(Book.all, :count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST delete" do
    let!(:book)  { FactoryBot.create(:book, title: "El ttulo", author: "el autro" ) }
    it "delete a book" do
      expect {
        delete api_v1_book_path(book) 
      }.to change {Book.count}.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
  

end


