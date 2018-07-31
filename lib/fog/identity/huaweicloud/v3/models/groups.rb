require 'fog/huaweicloud/models/collection'
require 'fog/identity/huaweicloud/v3/models/group'

module Fog
  module Identity
    class HuaweiCloud
      class V3
        class Groups < Fog::HuaweiCloud::Collection
          model Fog::Identity::HuaweiCloud::V3::Group

          def all(options = {})
            load_response(service.list_groups(options), 'groups')
          end

          def find_by_id(id)
            cached_group = find { |group| group.id == id }
            return cached_group if cached_group
            group_hash = service.get_group(id).body['group']
            Fog::Identity::HuaweiCloud::V3.group.new(
              group_hash.merge(:service => service)
            )
          end

          def destroy(id)
            group = find_by_id(id)
            group.destroy
          end
        end
      end
    end
  end
end
