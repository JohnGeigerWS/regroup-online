require 'rails_helper'

RSpec.describe SupportRequest, type: :model do
  describe 'record creation' do
    it "succeeds when all fields present" do
      request = build(:support_request)
      expect(request).to be_truthy
    end

    it "defaults completed to false" do
      request_hash = FactoryGirl.attributes_for(:support_request).except(:completed)
      request = SupportRequest.create(request_hash)
      expect(request.completed).to be_falsy
    end
  end

  describe 'fails validations' do
    scenario "when name is empty" do
      request = build(:support_request, name: '')
      expect(request.save).to be_falsy
      expect(request.errors).to include(:name)
      expect(request.errors[:name]).to include("can't be blank")
    end

    scenario "when email empty" do
      request = build(:support_request, email: '')
      expect(request.save).to be_falsy
    end

    scenario "when subject is empty" do
      request = build(:support_request, subject: '')
      expect(request.save).to be_falsy
    end

    scenario "when message is empty" do
      request = build(:support_request, message: '')
      expect(request.save).to be_falsy
    end
  end
end
