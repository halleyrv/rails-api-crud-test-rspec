require 'rails_helper'

describe 'Books Api', type: :request do
  let(:first_author) { FactoryBot.create(:author)}
  let(:second_author) { FactoryBot.create(:author_two)}  
  describe "Gets Books" do
    before do
      FactoryBot.create(:book, title: "Quijote", author: first_author)
      FactoryBot.create(:book, title: "Planta", author: second_author) 
    end
    
    it 'returns all books' do
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
            'id' => 1,
            'name' => "Quijote",
            'author_name' => "Cesar Rivera",
            'author_age' =>  48
          },
          {
            "id"=>2, 
            "name"=>"Planta",
            "author_name"=>"Miguel Vasconcellos", 
            "author_age"=>50 
          }
        ]
      )
    end
  end

  describe "POST books" do 
    let(:first_author_params) { FactoryBot.attributes_for(:author)}
    it 'create new book' do
      expect {
        post "/api/v1/books", params: {
          book: { title: "The martian" }, 
          author: first_author_params
        }
      }.to change(Book.all,:count).by(1)
      expect(response).to have_http_status(:created)
      expect(Author.count).to eql(1)
      expect(response_body).to eq(
        {
          'id' => 3,
          'name' => "The martian",
          'author_name' => "#{first_author_params[:first_name]} #{first_author_params[:last_name]}",
          'author_age' =>  48
        } 
      )
    end
    it "invalid values create new book" do
      expect {
        post "/api/v1/books", params: {
           book: {title: ""} ,
           author: {first_name: "", last_name: "", age: nil}
        }
      }.not_to change(Book.all, :count)
      expect(response.body).to include("can't be blank","is too short (minimum is 3 characters)")
      
    end
  end

  describe "POST delete" do
    let!(:book)  { FactoryBot.create(:book, title: "El ttulo", author: first_author ) }
    it "delete a book" do
      expect {
        delete api_v1_book_path(book) 
      }.to change {Book.count}.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
  

end


