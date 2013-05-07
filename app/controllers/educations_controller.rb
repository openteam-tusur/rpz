class EducationsController < ApplicationController
  sso_load_and_authorize_resource

  custom_actions :resource => :change_gpo_alternative_state

  layout false

  def change_gpo_alternative_state
    change_gpo_alternative_state!{
      @education.change_gpo_alternative_state
      render resource and return
    }
  end
end
