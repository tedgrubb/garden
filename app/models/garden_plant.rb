class GardenPlant < ActiveRecord::Base

  SECONDS_IN_DAY = (24 * 60 * 60)

  belongs_to :garden
  belongs_to :plant

  delegate :name, :days_to_harvest, to: :plant

  # Don't allow overlapping plants
  # validates :x_pos, uniqueness: {scope: [:garden_id, :y_pos], message: "is already taken"}
  # validates :y_pos, uniqueness: {scope: [:garden_id, :x_pos], message: "is already taken"}

  validate do |garden_plant|
    params = {
      garden_id: garden_plant.garden_id,
      x_pos: garden_plant.x_pos,
      y_pos: garden_plant.y_pos
    }

    if GardenPlant.unharvested.exists?(params)
      garden_plant.errors[:base] << "You can't overlap with unharvested plants"
    end
  end

  scope :harvested,   -> { where("harvested_at IS NOT NULL") }
  scope :unharvested, -> { where("harvested_at IS NULL") }

  def self.group_by_plant(collection)
    collection
      .group_by { |gp| [gp.plant_id, gp.created_at.to_i] }
      .sort_by { |group|
        garden_plant = group.last.first
        garden_plant.time_remaining
      }
  end

  def time_remaining
    (harvest_time - Time.now).to_i / SECONDS_IN_DAY
  end

  def harvest_time
    [Time.now, (created_at + days_to_harvest.days)].max.beginning_of_day
  end

  def validate_overlapness
    GardenPlant.unharvested.where(garden_id: garden_id, x_pos: x_pos, y_pos: y_pos)
  end
end