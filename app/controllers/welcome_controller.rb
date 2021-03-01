class WelcomeController < ApplicationController
  def index
    @username = params[:name] || "Guest"
  end
end
