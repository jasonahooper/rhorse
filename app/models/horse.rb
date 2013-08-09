class Horse < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :sire, class_name: "Horse"
  belongs_to :dam, class_name: "Horse"
end
