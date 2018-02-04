class Stadium < ApplicationRecord
  require 'csv'
  
  validates :name,
            length: { maximum: 40 },
            presence: true
  validates :city,
            length: { maximum: 20 },
            presence: true
  validates :capacity,
            numericality: { only_integer: true, greater_than: 0 },
            length: { maximum: 6 },
            presence: true
            
  # Import all the stadiums in the file
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      name     = row['Name']
      city     = row['City']
      capacity = row['Capacity']
      
      # todo handle exceptions
      Stadium.create!(:name => name, :city => city, :capacity => capacity)
    end
  end
end
