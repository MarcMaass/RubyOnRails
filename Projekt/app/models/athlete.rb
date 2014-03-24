class Athlete < ActiveRecord::Base
  include AthletesHelper
  # associations
  has_and_belongs_to_many :organization_units
  has_many :performances
  has_many :disciplines, :through => :performances
  has_one :examiner
  has_one :district_chief
  # foreign keys
  belongs_to :gender
  belongs_to :location
  # associations and keys for examiners
  has_and_belongs_to_many :sports
  belongs_to :organization_unit
  # associations for district chiefs
  has_one :district
  # secure password
  has_secure_password
  # attributes
  attr_accessible :picture, :picture_delete, :birthday, :email, :first_name, :house_number, :last_name, :phone, :street, :location, :activated, :picture, :gender_id, :password, :password_confirmation, :organization_unit
  # when picture is uploaded
  has_attached_file :picture, { :styles => { :small => '150x150', :thumbnail => '50x50' }, 
    :path => ':rails_root/app/assets/user_gallery/users/:id_:style.:extension', 
    :default_url => 'missing/:style.png',
    :url => 'users/:id_:style.:extension'
  }
  # validators
  validate :correct_location
  validate :correct_birthday
  validates :email, :last_name, :first_name, :birthday, :gender, :street, :house_number, :presence => true  
  validates :email, :uniqueness => true  
  #validates :house_number, :format => {:with => /[1-9]\d+[abcdefg]?/}
  validates_attachment :picture, :size => { :in => 0..1.megabytes} 
  validates :password, :presence => true, :length => {:minimum => 8}, :if => :validate_password? 
  validates_confirmation_of :password, :if => :validate_password?
  
  def validate_password?
    password.present? || password_confirmation.present?
  end
  
  def correct_birthday
    if not birthday
      errors.add(:birthday, "darf nicht leer sein.")
    elsif 6.years.ago.year < birthday.year 
      errors.add(:birthday, "muss mindestens #{6.years.ago.year} geboren sein")
    end
  end
  
  def correct_location
    if not location
      errors.add(:location, "Es konnte kein Ort gefunden werden.")
    end
  end    
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def postal_code_and_name
    return nil unless location
    "#{location.postal_code_and_name}"
  end
  
  def full_name_and_email
    "#{self.first_name} #{self.last_name} (#{self.email})"
  end
end
