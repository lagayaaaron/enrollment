class HomeController < ApplicationController
    skip_authorization_check
    def index
      # any code you want to execute when the root page is accessed
    end
  end
  