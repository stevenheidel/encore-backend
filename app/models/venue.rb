class Venue
  include Concerns::Lastfmable

  field :city, type: String
  field :country, type: String
  field :street, type: String
  field :postalcode, type: String
  field :coordinates, type: Array, default: [0,0]

  has_many :events
  embeds_many :instagram_locations
  accepts_nested_attributes_for :instagram_locations # for RailsAdmin

  index({coordinates: '2d'}, {min: -180, max: 180})

  validates_presence_of :name
  validate :validate_coordinates

  def latitude
    self.coordinates[1]
  end

  def longitude
    self.coordinates[0]
  end

  def latitude=(num)
    self.coordinates[1] = num
  end

  def longitude=(num)
    self.coordinates[0] = num
  end

  private
  def validate_coordinates
    invalid_coordinates = []

    if (self.coordinates[0].nil? and self.coordinates[1].present?) or
       (self.coordinates[1].nil? and self.coordinates[0].present?)
      invalid_coordinates = [true]
    end

    if(self.coordinates[0].present? and self.coordinates[1].present?)
      invalid_coordinates = self.coordinates.map{ |coordinate|
        coordinate.is_a? Numeric or
        (coordinate.is_a? String and (coordinate.strip =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/) == 0)
      }.select{ |e| e == false }
    end
    errors.add(:coordinates, I18n.t('mongoid.errors.models.venue.attributes.coordinates')) unless invalid_coordinates.empty?
  end
end