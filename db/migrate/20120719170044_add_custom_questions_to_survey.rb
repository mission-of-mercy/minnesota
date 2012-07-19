class AddCustomQuestionsToSurvey < ActiveRecord::Migration
  def change
    add_column    :surveys, :time_arrived,                       :datetime
    add_column    :surveys, :reason_for_no_dental_care,          :string
    add_column    :surveys, :number_of_family_members_at_clinic, :integer
    add_column    :surveys, :medical_assistance,                 :boolean

    remove_column :surveys, :medicaid_or_chp_plus
  end
end
