class PeopleController < ApplicationController
  include CRUDActions

  def entity
    Person
  end
end
