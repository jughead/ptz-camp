class Admin::FieldSetsController < Admin::ApplicationController
  load_resource :camp
  decorate_current_camp
  before_action :load_or_init_field_set

  def edit
    authorize! :edit, @camp_field_set
    decorate
  end

  def update
    authorize! :update, @camp_field_set

    CampFieldSets::UpdateCommand.new.call(camp_field_set: @camp_field_set, params: params) do |m|
      m.success do |_camp_field_set|
        redirect_to admin_camp_path(@camp)
      end

      m.failure do |result|
        result.errors(full: true).each do |message|
          @camp_field_set.errors.add(:fields, message.text)
        end
        decorate
        render :edit
      end
    end
  end

  private

  def decorate
    @camp_field_set.fields = @camp_field_set.fields.to_json
  end

  def load_or_init_field_set
    @camp_field_set = @camp.camp_field_set || @camp.build_camp_field_set
  end
end
