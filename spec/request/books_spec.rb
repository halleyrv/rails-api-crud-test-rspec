require 'rails_helper'

describe 'Books Api', type: :request do
  it 'returns all books' do
    FactoryBot.create(:book, title: "Quijote", author: "Cervantes")
    FactoryBot.create(:book, title: "Planta", author: "Vasconcellos")
    get '/api/v1/books'
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end