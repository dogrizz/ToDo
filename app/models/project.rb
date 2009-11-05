class Project < ActiveRecord::Base
	validates_length_of :name, :within => 3..20, :message => "must be present!"
	validates_uniqueness_of :name, :message => "must be unique"
end
