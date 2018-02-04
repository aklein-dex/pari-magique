class Team < ApplicationRecord
  require 'csv'
  
  has_and_belongs_to_many :tournaments
  has_many :games

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :code,
            length: { maximum: 3 },
            presence: true
  validates :flag,
            length: { maximum: 20 },
            presence: true
  validates :selection,
            presence: true

  enum selection: [:country, :club]
  
  def flag_path
    if self.country?
      "flags/countries/" + self.flag
    else
      "flags/clubs/" + self.flag
    end
  end

  # Import all the teams in the file
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      name = row['Name']
      code = row['Code']
      flag = code.downcase + '.png'
      selection = 0 #TODO be able to add clubs
      
      # todo handle exceptions
      Team.create!(:name => name, :code => code, :flag => flag, :selection => selection)
    end
  end
end
