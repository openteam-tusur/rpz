class SemestersController < ApplicationController
  sso_load_and_authorize_resource

  belongs_to :year do
    belongs_to :faculty do
      belongs_to :course do
        belongs_to :group
      end
    end
  end
end
