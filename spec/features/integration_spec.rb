require "spec_helper"

feature "Reading in the browser", browser: true do
  it "displays the configured title" do
    Apitome.configuration.title = "Test Documentation"
    visit "/api/docs"

    expect(page).to have_text("Test Documentation")
  end

  it "displays the expected navigation" do
    visit "/api/docs"

    expect(page).to have_text("README")
    expect(page).to have_text("Access Tokens")
    expect(page).to have_text(<<-TEXT.strip_heredoc)
      API Documentation
      Current Version
      /api/v1/*
      /api/edge/* (forthcoming version)
    TEXT
  end

  it "allows navigating to different sections" do
    visit "/api/docs"
    click_link "Access Tokens"

    expect(page).to have_text("Access Tokens")
    expect(page).to have_text(<<-TEXT.strip_heredoc)
      Client access token (client credentials)
      User access token (password)
      - When the user credentials are invalid
      - When the user has been locked out
      User access token (refresh token)
    TEXT
  end

  it "displays the expected results" do
    visit "/api/docs"

    expect(page).to have_text(<<-TEXT.strip_heredoc)
      A user access token is not always explicitly required, for instance if the user is unable to sign in and a
      password reset is desired, or similarly, you may want to confirm username/email availability during registration.
      For these types of requests only a client access token is required.
    TEXT

    expect(page).to have_text(<<-TEXT.strip_heredoc)
      Endpoint

      POST /api/oauth/token
    TEXT

    expect(page).to have_text(<<-TEXT.strip_heredoc)
      Parameters

      Name                    Description                   Expected
      client_id required      Client ID (as provided)
      client_secret required  Client Secret (as provided)
      grant_type required     Grant Type                    client_credentials
    TEXT

    expect(page).to have_text(<<-TEXT.strip_heredoc)
      Request

      Route
      POST /api/oauth/token

      Headers
      Content-Type: application/json
      Host: example.com
      Cookie:

      Body
      {
        "client_id": "04e83c5f62d57a5458c8fd970cf499677156274ab02895cf8dabcc6e07beb2b1",
        "client_secret": "5c49359ffdc9b5ee6914716e573f9916ad6cbac1c13f4863a9082dcfdc7dab07",
        "grant_type": "client_credentials"
      }
    TEXT

    expect(page).to have_text(<<-TEXT.strip_heredoc)
      Response

      Status
      200

      Headers
      X-Frame-Options: SAMEORIGIN
      X-XSS-Protection: 1; mode=block
      X-Content-Type-Options: nosniff
      Cache-Control: no-store
      Pragma: no-cache
      Content-Type: application/json; charset=utf-8
      ETag: "2afa9848097a0e54140f761cdff32919"
      X-Request-Id: abd02f7a-26a8-4757-8157-0540e97ba8c5
      X-Runtime: 0.020698
      Content-Length: 123

      Body
      {
        "access_token": "7200227cb2d451f60e7c8a36c94793b06e1006a32d3282e47b73b3fb0605906d",
        "token_type": "bearer",
        "expires_in": 1800
      }
    TEXT
  end

  context "for a non-default doc path" do
    before do
      Apitome.configuration.title = "Test Documentation"
    end

    it "displays the expected docs" do
      visit "/api/docs/v2"
      expect(page).to have_text("Test Documentation (v2)")
      expect(page).to have_text("Access Tokens (v2)")
    end
  end
end
