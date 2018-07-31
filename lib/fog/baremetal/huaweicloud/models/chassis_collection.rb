require 'fog/huaweicloud/models/collection'
require 'fog/baremetal/huaweicloud/models/chassis'

module Fog
  module Baremetal
    class HuaweiCloud
      class ChassisCollection < Fog::HuaweiCloud::Collection
        model Fog::Baremetal::HuaweiCloud::Chassis

        def all(options = {})
          load_response(service.list_chassis_detailed(options), 'chassis')
        end

        def summary(options = {})
          load_response(service.list_chassis(options), 'chassis')
        end

        def details(options = {})
          Fog::Logger.deprecation("Calling HuaweiCloud[:baremetal].chassis_collection.details will be removed, "\
                                  " call .chassis_collection.all for detailed list.")
          all(options)
        end

        def find_by_uuid(uuid)
          new(service.get_chassis(uuid).body)
        end
        alias get find_by_uuid

        def destroy(uuid)
          chassis = find_by_id(uuid)
          chassis.destroy
        end

        def method_missing(method_sym, *arguments, &block)
          if method_sym.to_s =~ /^find_by_(.*)$/
            load(service.list_chassis_detailed($1 => arguments.first).body['chassis'])
          else
            super
          end
        end
      end
    end
  end
end
