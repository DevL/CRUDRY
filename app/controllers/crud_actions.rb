module CRUDActions
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def entity(entity_class)
      define_method(:entity) { entity_class }
    end
  end

  def index
    set_entities_instance_variable entity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: entities_instance_variable }
    end
  end

  def show
    set_entity_instance_variable entity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: entity_instance_variable }
    end
  end

  def new
    set_entity_instance_variable entity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: entity_instance_variable }
    end
  end

  def create
    set_entity_instance_variable entity.new(entity_params)

    respond_to do |format|
      if entity_instance_variable.save
        format.html { redirect_to entity_instance_variable, notice: created_message }
        format.json { render json: entity_instance_variable, status: :created, location: entity_instance_variable }
      else
        format.html { render action: 'new' }
        format.json { render json: entity_instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    set_entity_instance_variable entity.find(params[:id])
  end

  def update
    set_entity_instance_variable entity.find(params[:id])

    respond_to do |format|
      if entity_instance_variable.update_attributes(params[entity_params])
        format.html { redirect_to entity_instance_variable, notice: updated_message }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: entity_instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_entity_instance_variable entity.find(params[:id])
    entity_instance_variable.destroy

    respond_to do |format|
      format.html { redirect_to entities_url }
      format.json { head :no_content }
    end
  end

  private

  def created_message
    "#{entity_name.capitalize} was successfully created."
  end

  def updated_message
    "#{entity_name.capitalize} was successfully updated."
  end

  def entities_url
    send "#{entities_name}_url"
  end

  def entity_params
    params[entity_name.to_sym]
  end

  def entity_name
    entity.name.downcase
  end

  def entities_name
    entity_name.pluralize
  end

  def entity_instance_variable
    instance_variable_get(entity_instance_variable_name)
  end

  def entities_instance_variable
    instance_variable_get(entities_instance_variable_name)
  end

  def entity_instance_variable_name
    "@#{entity_name}"
  end

  def set_entity_instance_variable(value)
    instance_variable_set(entity_instance_variable_name, value)
  end

  def entities_instance_variable_name
    "@#{entities_name}"
  end

  def set_entities_instance_variable(value)
    instance_variable_set(entities_instance_variable_name, value)
  end
end
