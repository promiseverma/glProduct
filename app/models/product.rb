class Product < ActiveRecord::Base
	validates :name, :description, :price,  presence: true
	validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/, :message => "should be either numeric or float upto two decimal places." }, :numericality => {:greater_than => 0, :less_than => 1000000}
end
