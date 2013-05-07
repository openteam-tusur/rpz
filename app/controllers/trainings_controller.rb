class TrainingsController < ApplicationController
  sso_load_and_authorize_resource

  custom_actions :resource => :change_monitored_state

  layout false

  def change_monitored_state
    change_monitored_state!{
      @training.change_monitored_state
      render resource and return
    }
  end
end
