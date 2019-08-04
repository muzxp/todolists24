class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { in: %w(male female) }
  validate :name_not_both_null
  validate :sue_is_not_a_boy

  def name_not_both_null
    if (first_name.nil? and last_name.nil?) or (first_name=="" and last_name=="") then
      errors.add(:first_name, "first_name and last_name are both null!")
      errors.add(:last_name, "first_name and last_name are both null!")
    end
  end

  def sue_is_not_a_boy
    if first_name=="Sue" and gender=="male" then
      errors.add(:first_name, "Sue is not a boy!")
    end
  end

  def self.get_all_profiles(min_birth_year, max_birth_year)
    Profile.where("birth_year BETWEEN ? AND ?",min_birth_year,max_birth_year).order(birth_year: :asc)
  end
  
end
