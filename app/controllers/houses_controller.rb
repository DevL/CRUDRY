class HousesController < ApplicationController
  include CRUDActions

  def entity
    House
  end
end
