class School::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(
      :name,
      :town_id,
      :address,
      :contact_name,
      :phone,
      :confirmed_participation,
      :visit_dates,
      {disciplines: []},
      {available_equipment: []},
      :meetup_options,
      :remarks,
      :email,
      :password,
      :password_confirmation
    )
  end
end
