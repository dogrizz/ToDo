class Project < ActiveRecord::Base
	validates_length_of :name, :minimum => 3
	has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "15x15>" }
end
