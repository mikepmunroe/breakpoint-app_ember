require 'spec_helper'

describe SessionController do
  it "authenticates with email" do
    user = create(:user)
    post :create, { email: user.email, password: 'testing' }
    results = JSON.parse(response.body)
    results['api_key']['access_token'].should =~ /\S{32}/
    results['api_key']['user_id'].should eq user.id
  end

  it "fails to authenticate with invalid info" do
    user = create(:user)
    post :create, { email: user.email, password: 'huh' }
    response.status.should eq 401
  end

  it "destroys sessions on request" do
    api_key = create(:session_api_key)
    user = api_key.user
    @request.headers['Authorization'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
    delete :destroy
    response.status.should eq 200
    ApiKey.active.find_by(access_token: api_key.access_token).should be nil
  end
end

