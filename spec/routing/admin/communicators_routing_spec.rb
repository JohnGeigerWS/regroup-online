require "rails_helper"

RSpec.describe Admin::CommunicatorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/communicators").to route_to("admin/communicators#index")
    end
  end
end
