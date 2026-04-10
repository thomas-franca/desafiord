require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe 'routes' do
    it 'routes to #show' do
      expect(get: '/cart').to route_to('carts#show')
    end

    it 'routes POST /cart to #add_product' do
      expect(post: '/cart').to route_to('carts#add_product')
    end

    it 'routes POST /cart/add_product to #add_product' do
      expect(post: '/cart/add_product').to route_to('carts#add_product')
    end

    it 'routes to #add_item via POST' do
      expect(post: '/cart/add_item').to route_to('carts#add_item')
    end

    it 'routes to #remove_product via DELETE' do
      expect(delete: '/cart/10').to route_to('carts#remove_product', product_id: '10')
    end
  end
end
