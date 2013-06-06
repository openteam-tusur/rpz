class EducationsController < ApplicationController
  sso_load_and_authorize_resource

  custom_actions :resource => [:change_gpo_alternative_state, :change_active_state]

  layout false

  def change_gpo_alternative_state
    change_gpo_alternative_state!{
      @education.change_gpo_alternative_state
      render resource, :locals => { :active_state => false } and return
    }
  end

  def change_active_state
    change_active_state! {
      @education.change_active_state
      redirect_to [@education.faculty.year, @education.faculty, @education.course, @education.group] and return
    }
  end
end
