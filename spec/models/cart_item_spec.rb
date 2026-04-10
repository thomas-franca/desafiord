require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:cart_item, quantity: 1)).to be_valid
  end

  it 'is invalid with quantity less than or equal to zero' do
    expect(build(:cart_item, quantity: 0)).not_to be_valid
    expect(build(:cart_item, quantity: -1)).not_to be_valid
  end

  it 'is invalid without cart' do
    cart_item = build(:cart_item, cart: nil)
    expect(cart_item).not_to be_valid
    expect(cart_item.errors[:cart]).to include('must exist')
  end

  it 'is invalid without product' do
    cart_item = build(:cart_item, product: nil)
    expect(cart_item).not_to be_valid
    expect(cart_item.errors[:product]).to include('must exist')
  end
end
