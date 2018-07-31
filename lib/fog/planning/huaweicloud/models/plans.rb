require 'fog/huaweicloud/models/collection'
require 'fog/planning/huaweicloud/models/plan'

module Fog
  module HuaweiCloud
    class Planning
      class Plans < Fog::HuaweiCloud::Collection
        model Fog::HuaweiCloud::Planning::Plan

        def all(options = {})
          load_response(service.list_plans(options))
        end

        def find_by_uuid(plan_uuid)
          new(service.get_plan(plan_uuid).body)
        end
        alias get find_by_uuid

        def method_missing(method_sym, *arguments, &block)
          if method_sym.to_s =~ /^find_by_(.*)$/
            all.find do |plan|
              plan.send($1) == arguments.first
            end
          else
            super
          end
        end
      end
    end
  end
end
