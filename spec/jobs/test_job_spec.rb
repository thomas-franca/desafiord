require 'rails_helper'

RSpec.describe MarkCartAsAbandonedJob, type: :job do
  describe '#perform' do
    it 'delegates abandoned carts handling to ManageAbandonedCartsJob' do
      expect(ManageAbandonedCartsJob).to receive(:perform_now)
      described_class.new.perform
    end
  end
end
