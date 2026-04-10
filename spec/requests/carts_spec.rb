require 'rails_helper'

RSpec.describe "/cart", type: :request do
  let!(:product) { create(:product, price: 10.0) }

  describe "POST /cart" do
    it "adiciona o produto ao carrinho" do
      post "/cart", params: { product_id: product.id, quantity: 1 }, as: :json

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["products"].first["id"]).to eq(product.id)
      expect(json_response["products"].first["quantity"]).to eq(1)
    end

    it "incrementa a quantidade de um produto já existente no carrinho" do
      post "/cart", params: { product_id: product.id, quantity: 1 }, as: :json

      expect do
        post "/cart", params: { product_id: product.id, quantity: 2 }, as: :json
      end.to change { CartItem.find_by(product: product).quantity }.by(2)
    end

    it "retorna erro quando o produto não existe" do
      post "/cart", params: { product_id: 999_999, quantity: 1 }, as: :json

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Produto não encontrado")
    end

    it "retorna erro quando quantity é inválida" do
      post "/cart", params: { product_id: product.id, quantity: 0 }, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq("Quantidade deve ser maior que zero")
    end
  end

  describe "POST /cart/add_item" do
    it "altera a quantidade quando o produto já existe no carrinho" do
      post "/cart", params: { product_id: product.id, quantity: 1 }, as: :json
      post "/cart/add_item", params: { product_id: product.id, quantity: 2 }, as: :json

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["products"].first["quantity"]).to eq(3)
    end
  end

  describe "DELETE /cart/:product_id" do
    before do
      post "/cart", params: { product_id: product.id, quantity: 2 }, as: :json
    end

    it "remove o produto do carrinho" do
      delete "/cart/#{product.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["products"]).to be_empty
    end

    it "retorna erro ao tentar remover um produto inexistente" do
      delete "/cart/999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Produto não encontrado")
    end
  end
end
