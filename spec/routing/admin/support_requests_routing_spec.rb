require "rails_helper"

RSpec.describe Admin::SupportRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/support_requests").to route_to("admin/support_requests#index")
    end
  end
end
