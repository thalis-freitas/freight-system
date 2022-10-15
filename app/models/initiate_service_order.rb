class InitiateServiceOrder < ApplicationRecord
  belongs_to :service_order
  belongs_to :mode_of_transport
end
