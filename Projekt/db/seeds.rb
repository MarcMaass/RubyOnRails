# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#["Ausdauer","Kraft","Schnelligkeit","Koordination"].each do |name|
#    Category.create!(:name => name)
#end

# Creat Gender
["w","m"].each do |gender|
    Gender.create!(:sex => gender)
end

# Creat Medals
Medal.create!(:sign => "Teilgenommen", :points => 0)
Medal.create!(:sign => "Bronze", :points => 1)
Medal.create!(:sign => "Silber", :points => 2)
Medal.create!(:sign => "Gold", :points => 3)

# Need for Performance
Unit.create(:name => "bestanden")

# Read Data
json = ActiveSupport::JSON.decode(File.read('db/erw_2013.json'))

# Lists need for Data
category = []
sport = []
age_group = []
unit = []
dis = []
disage = []

# Method for Creating User
def createuser(clazz, info, gender, location, pass = 'webeng12')
    ret = clazz.new
    info.each_pair do |k, v|
      ret[k] = v
    end
    ret.gender = Gender.find_by_sex(gender)
    ret.location = Location.find_by_postal_code(location)
    ret.password, ret.password_confirmation = pass, pass 
    ret
end

# Helper Method for formating and save Age
def creat_age_range(ageRange)
    age_range = ageRange.split("-")
    min_age = age_range[0].to_i
    max_age = age_range[1].to_i
    AgeRange.create(:min_age => min_age, :max_age => max_age)
end

# Helper Method for saving Discipline
def creat_discipline(json)
    # Create Discipline
    discipline = Discipline.new(:name => json["disciplin"], :year => "1.1.2013")
    # save query in vars for Discipline joins
    sp = Sport.find_by_name(json["disc_group"])
    cat = Category.find_by_name(json["category"])
    ge = Gender.find_by_sex(json["gender"])
    # when no unit set
    if json["req_unit"].nil?
      un = Unit.find_by_name("bestanden")
    else
      un = Unit.find_by_name(json["req_unit"])
    end
    # joins Diciplines
    sp.disciplines << discipline
    cat.disciplines << discipline
    un.disciplines << discipline
    ge.disciplines << discipline
    # save Discipline
    discipline.save
end

# Helper Method for join Discipline with Age
def creat_disciplineage(json)
    # need for Age select
    age_range = json["age_group"].split("-")
    min_age = age_range[0].to_i
    # save query in vars for join Dicipline with Age
    ag = AgeRange.find_by_min_age(min_age)
    ge = Gender.find_by_sex(json["gender"])
    di = Discipline.find_by_name_and_gender_id(json["disciplin"],ge.id)
    # Creat new entry
    disag = DisciplineAge.new()
    di.discipline_ages << disag
    ag.discipline_ages << disag
end

# Helper Method for Create a Performance
def creat_requiredperformance(json)
    # change all min values to sec
    if json["req_unit"] == "Min."
      splitTime = json["requirement"].split(":")
      value = splitTime[0].to_f * 60 + splitTime[1].to_f
    else
      # need because "," can not cast to float
      s = json["requirement"]
      if s.index(',').nil?
        value = s.to_f
      else
         s[s.index(',')] = '.'
         value = s.to_f
      end
    end
    # save query in vars for Performance joins
    reqper = RequiredPerformance.new(:value => value)
    med = Medal.find_by_sign(json["level"])
    ge = Gender.find_by_sex(json["gender"])
    di = Discipline.find_by_name_and_gender_id(json["disciplin"],ge.id)
    age_range = json["age_group"].split("-")
    min_age = age_range[0].to_i
    ag = AgeRange.find_by_min_age(min_age)
    disag = DisciplineAge.find_by_discipline_id_and_age_range_id(di.id,ag.id)
    # join Performance with Meadl and Age
    med.required_performances << reqper
    disag.required_performances << reqper
end

# Main loop
json.each do |json|
  # Check List if Category is not Set
  if not category.include?(json["category"])
    category += [json["category"]]
    Category.create!(:name => json["category"])
  end
  # Check List if Discipline is not Set
  if not sport.include?(json["disc_group"])
    sport += [json["disc_group"]]
    Sport.create(:name => json["disc_group"])
  end
  # Check List if Age is not Set
  if not age_group.include?(json["age_group"])
    age_group += [json["age_group"]]
    creat_age_range(json["age_group"])
  end
  # Check List if Unit is not Set an not Nil
  if not unit.include?(json["req_unit"]) and not json["req_unit"].nil?
    unit += [json["req_unit"]]
    Unit.create(:name => json["req_unit"])
  end
  # Creat a String need for check
  gen_dis = json["disciplin"] + "/" + json["gender"] 
  # Check List if Discipline and Age is not Set
  if not dis.include?(gen_dis)
    dis += [gen_dis]
    creat_discipline(json)
  end  
  # Creat a String need for check
  age_dis = json["disciplin"] + "/" + json["gender"] + "/" + json["age_group"]
  # Check List if Discipline, Age and Gender is not Set
  if not disage.include?(age_dis)
    disage += [age_dis]
    creat_disciplineage(json)
  end
  creat_requiredperformance(json)
end

# FederalState
["Hessen","Rheinland-Pfalz"].each do |federalstate|
    FederalState.create!(:name => federalstate)
end

["Kreisfreie Stadt Wiesbaden"].each do |district|
    fedst = FederalState.find_by_name("Hessen")
    district = District.new(:name => district)
    fedst.districts << district
    district.save
end

# District
district = District.find_by_name("Kreisfreie Stadt Wiesbaden")

# Postalcodes
["65207","65205","65187","65191","65203"].each do |postcode|
    location = Location.new(:name => "Wiesbaden", :postal_code => postcode)
    district.locations << location
    location.save
end

# Organisations Loactions and SportFacilities
location = Location.new(:name => "Mainz-Kostheim", :postal_code => "55264")
district.locations << location
location.save

organun = OrganizationUnit.new(:name =>  "Turnverein Waldstra\u00DFe 1902 e.V.", :street=> "Buchenstra\u00DFe", :house_number => 2, :email => "info@tv-waldstrasse.de", :url => "http://www.tv-waldstrasse.de", :phone_number => "+49 (611) 728 736")
location = Location.find_by_postal_code("65187")
location.organization_units << organun
organun.save

sportfac = SportFacility.new(:name => "Sportplatz Rheinh\u00F6he", :street =>  "Steinberger Stra\u00DFe", :house_number => 10)
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

organun = OrganizationUnit.new(:name =>  "Turnverein Kostheim 1877 e.V.", :street=> "Hauptstra\u00DFe", :house_number => 137, :email => "GS@turnverein-kostheim.de", :url => "http://www.turnverein-kostheim.de", :phone_number => "+49 (6134) 280 298")
location = Location.find_by_postal_code("55264")
location.organization_units << organun
organun.save

sportfac = SportFacility.new(:name => "TVK-Sportplatz Maaraue", :street =>  "Auf der Maaraue", :house_number => 7)
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

organun = OrganizationUnit.new(:name =>  "TV Am\u00F6neburg 1887 e.V.", :street=> "Untere Bleiche", :house_number => 8, :email => "volker@sportabzeichen-wiesbaden.de", :url => "http://tvamoeneburg.wordpress.com", :phone_number => "+49 (611) 507 916")
location = Location.find_by_postal_code("65203")
location.organization_units << organun
organun.save

sportfac = SportFacility.new(:name => "Dyckerhoff-Sportfeld", :street =>  "Bergmannstra\u00DFe", :house_number => 3)
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

sportfac = SportFacility.new(:name => "Frbelhalle in Am\u00F6neburg", :street =>  "Dyckerhoffstra\u00DFe", :house_number => 23)
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

sportfac = SportFacility.new(:name => "Hallenbad Kostheim", :street =>  "Waldhofstra\u00DFe", :house_number => 11)
location = Location.find_by_postal_code("55264")
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

organun = OrganizationUnit.new(:name =>  "Turn- und Sportgemeinde 1861 Sonnenberg", :street=> "Am Schlo\u00DFberg", :house_number => 34, :email => "Info@TSG-Sonnenberg.de", :url => "http://www.tsg-sonnenberg.de", :phone_number => "+49 (611) 544 826")
location = Location.find_by_postal_code("65191")
location.organization_units << organun
organun.save

sportfac = SportFacility.new(:name => "Turnhalle Sonnenberg", :street =>  "Am Schlo\u00DFberg", :house_number => 24)
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

sportfac = SportFacility.new(:name => "Waldsportplatz Rambach", :street =>  "Trompeterstra\u00DFe", :house_number => 1)
location = Location.find_by_postal_code("65207")
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

organun = OrganizationUnit.new(:name =>  "Turnverein 1890 Breckenheim", :street=> "Am gro\u00DFen Garten", :house_number => 4, :email => "j.portmann@sidis.de", :url => "http://www.turnvereinbreckenheim.de", :phone_number => "+49 (6122) 128 606")
location = Location.find_by_postal_code("65207")
location.organization_units << organun
organun.save

sportfac = SportFacility.new(:name => "Sportplatz Breckenheim und Wallau", :street =>  "Am Waldrand", :house_number => 2)
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

organun = OrganizationUnit.new(:name =>  "Turnverein 1846 Erbenheim", :street=> "Am B\u00FCrgerhaus", :house_number => 4, :url => "http://www.tv-erbenheim.de", :phone_number => "+49 (611) 788 8748")
location = Location.find_by_postal_code("65205")
location.organization_units << organun
organun.save

sportfac = SportFacility.new(:name => "Sportplatz Am Oberfeld", :street =>  "Oberfeld", :house_number => 7)
location.sport_facilities << sportfac
organun.sport_facilities << sportfac
sportfac.save

organun = OrganizationUnit.new(:name =>  "Turn- und Sportverein Wiesbaden-Rambach 1861 e.V.", :street=> "Ostpreussenstra\u00FCe", :house_number => 42, :url => "http://blog.tus-rambach.de", :phone_number => "+49 (611) 542 335")
location = Location.find_by_postal_code("65207")
location.organization_units << organun
organun.save

sportfac = SportFacility.find_by_name("Waldsportplatz Rambach")
organun.sport_facilities << sportfac

# Athletes
info = {:email => "mario@mario.de", :last_name => "Wandpflug", :first_name => "Mario", :birthday => "30.10.1988".to_date, :street => "Teststra\u00DFe", :house_number => 41, :phone => "0611 123456"}
orga_units = ["Turnverein Waldstra\u00DFe 1902 e.V.", "Turnverein 1846 Erbenheim"]
user = createuser(Athlete, info, 'm', '65187')
user.save!
user.organization_units << OrganizationUnit.find_by_name(orga_units)

info = {:email => "bruce@bruce.de", :last_name => "WillEs", :first_name => "Bruce", :birthday => "01.01.1989".to_date, :street => "Teststra\u00DFe", :house_number => 40, :phone => "0611 123"}
orga_units = ["Turnverein Waldstra\u00DFe 1902 e.V."]
user = createuser(Athlete, info, 'm', '65187')
user.save!
user.organization_units << OrganizationUnit.find_by_name(orga_units)

info = {:email => "jolly@jolly.de", :last_name => "Jumper", :first_name => "Jolly", :birthday => "30.10.1988".to_date, :street => "Teststra\u00DFe", :house_number => 41, :phone => "0611 123456"}
orga_units = ["Turnverein Waldstra\u00DFe 1902 e.V.", "Turnverein 1846 Erbenheim"]
user = createuser(Athlete, info, 'm', '65187')
user.save!
user.organization_units << OrganizationUnit.find_by_name(orga_units)

# Examiners

info = {:email => "marc@marc.de", :last_name => "Maa\u00DF", :first_name => "Marc", :birthday => "08.03.1980".to_date, :street => "Musterstra\u00DFe", :house_number => 12, :phone => "0611 65432" }
orga_units = "Turnverein 1846 Erbenheim"
user = createuser(Examiner, info, 'm', '65205')
user.organization_unit = OrganizationUnit.find_by_name(orga_units)
user.save!
user.organization_units << OrganizationUnit.find_by_name(orga_units)

# District Chiefs
info = {:email => "chefin@chef.de", :last_name => "Cheffe", :first_name => "Bossi", :birthday => "01.01.1950".to_date, :street => "Musterplatz", :house_number => 111, :phone => "0611 433434" }
orga_units = "Turn- und Sportgemeinde 1861 Sonnenberg"
user = createuser(DistrictChief, info, 'w', '65207')
user.save!
district = District.find(1)
district.district_chief = user
district.save!
user.organization_units << OrganizationUnit.find_by_name(orga_units)

# Some Performances for Athlete 1 in 2012
a = Athlete.find(1)
# performance 1
d = Discipline.where(:gender_id => a.gender, :name => '3000 m Lauf')[0]
p = Performance.new(:athlete => a,:value => (17.minutes + 5), :discipline => d, :examiner => Examiner.first(), :inspected => true, :date => "08.01.2012".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!
# performance 2
d = Discipline.where(:gender_id => a.gender, :name => '7,26 kg Kugelstoßen')[0]
p = Performance.new(:athlete => a,:value => 8.75, :discipline => d, :examiner => Examiner.first(), :inspected => true, :date => "05.05.2012".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!
# performance 3
d = Discipline.where(:gender_id => a.gender, :name => '100 m Laufen')[0]
p = Performance.new(:athlete => a,:value => 13.5, :discipline => d, :examiner => Examiner.first(), :inspected => true, :date => "08.06.2012".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!
# performance 4
d = Discipline.where(:gender_id => a.gender, :name => 'Hochsprung')[0]
p = Performance.new(:athlete => a,:value => 1.40, :discipline => d, :examiner => Examiner.first(), :inspected => true, :date => "08.01.2012".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!

# and in 2013
# 1
d = Discipline.where(:gender_id => a.gender, :name => '10 km Lauf')[0]
p = Performance.new(:athlete => a,:value => 50.minutes, :discipline => d, :examiner => Examiner.first(), :inspected => true, :date => "08.01.2013".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!
# 2
d = Discipline.where(:gender_id => a.gender, :name => 'Medizinballwurf')[0]
p = Performance.new(:athlete => a,:value => 12.0, :discipline => d, :examiner => Examiner.first(), :inspected => true, :date => "12.01.2013".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!
# 3
d = Discipline.where(:gender_id => a.gender, :name => '200 m Radfahren')[0]
p = Performance.new(:athlete => a,:value => 18.0, :discipline => d, :examiner => Examiner.first(), :inspected => true, :date => "15.01.2013".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!
# 4
d = Discipline.where(:gender_id => a.gender, :name => 'Hochsprung')[0]
p = Performance.new(:athlete => a,:value => 1.5, :discipline => d, :examiner => Examiner.first(), :inspected => false, :date => "30.01.2013".to_date, :district_chief => DistrictChief.first, :sport_facility => SportFacility.find(1))
p.save!

d = Discipline.where(:gender_id => a.gender, :name => 'Hochsprung')[0]
p = Performance.new(:athlete => a,:value => 1.5, :discipline => d, :examiner => Examiner.first(), :inspected => false, :date => "10.02.2013".to_date, :district_chief => nil, :sport_facility => SportFacility.find(1))
p.save!