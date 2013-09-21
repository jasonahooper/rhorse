class Horse < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :sire, class_name: "Horse"
  belongs_to :dam, class_name: "Horse"
  def sire_name
    return sire.name if sire
  end
  def dam_name
    return dam.name if dam
  end
end
