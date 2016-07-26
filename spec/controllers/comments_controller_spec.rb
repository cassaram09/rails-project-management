require_relative "../rails_helper.rb"

RSpec.describe CommentsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, :project_id => 1
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of comments for that Project" do
      
    end
  end
end