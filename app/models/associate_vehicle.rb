class AssociateVehicle < ApplicationRecord
  belongs_to :service_order
  belongs_to :vehicle
end
