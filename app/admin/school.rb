ActiveAdmin.register School do
  permit_params :name, :town_id, :address, :contact_name, :phone, :email,
                :confirmed_participation, :visit_dates, {disciplines: []},
                {available_equipment: []}, :meetup_options, :remarks,
                :password, :password_confirmation

  remove_filter :town

  index do
    selectable_column
    id_column
    column 'Име', :name
    column 'Град', :town do |row|
      auto_link row.town, row.town.name
    end
    column 'Акт.?', :confirmed_participation
    column 'Контакт', :contact_name
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'School Details' do
      f.input :name
      f.input :town, collection: Town.order('name ASC').includes(municipality: :state)
      f.input :address
      f.input :contact_name
      f.input :phone
      f.input :email, hint: 'При промяна, ще бъде изпратено писмо на този адрес за потвърждение.'
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :confirmed_participation
      f.input :visit_dates, as: :text
      f.input :disciplines, as: :check_boxes, collection: Options.for('disciplines').map { |id, label| [label, id.to_s] }
      f.input :available_equipment, as: :check_boxes, collection: Options.for('available_equipment').map { |id, label| [label, id.to_s] }
      f.input :meetup_options, as: :radio, collection: Options.for('meetup_options').map { |id, label| [label, id.to_s] }
      f.input :remarks, as: :text
    end
    f.actions
  end
end
