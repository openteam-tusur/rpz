class WelcomeController < ApplicationController
  def index
    redirect_to years_path if user_signed_in?
  end
end
