require 'fog/compute/models/server'
require 'fog/compute/huaweicloud/models/metadata'

module Fog
  module Compute
    class HuaweiCloud
      class Host < Fog::HuaweiCloud::Model
        attribute :host_name
        attribute :service_name
        attribute :details
        attribute :zone

        def initialize(attributes)
          attributes["service_name"] = attributes.delete "service"
          # Old 'connection' is renamed as service and should be used instead
          prepare_service_value(attributes)
          super
        end

        def details
          service.get_host_details(host_name).body['host']
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
