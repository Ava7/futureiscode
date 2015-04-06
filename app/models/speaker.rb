class Speaker < ActiveRecord::Base
  include Gravatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :company

  validates :name, presence: true

  def person_name
    name
  end

  def company_or_other
    company or other_company
  end
end
