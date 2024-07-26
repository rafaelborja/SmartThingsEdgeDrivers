-- Copyright 2022 SmartThings
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

local log = require "log"
local capabilities = require "st.capabilities"
local ZigbeeDriver = require "st.zigbee"
local defaults = require "st.zigbee.defaults"
local constants = require "st.zigbee.constants"
local zcl_clusters = require "st.zigbee.zcl.clusters"

local ias_zone_configuration = {
  cluster = zcl_clusters.IASZone.ID,
  attribute = zcl_clusters.IASZone.attributes.ZoneStatus.ID,
  minimum_interval = 1,
  maximum_interval = 900,
  data_type = zcl_clusters.IASZone.attributes.ZoneStatus.base_type
}

-- smokeDetector_defaults.default_ias_zone_configuration = ias_zone_configuration

local zigbee_smoke_driver_template = {
  supported_capabilities = {
    capabilities.smokeDetector,
    capabilities.battery,
    capabilities.healthCheck
  },
  sub_drivers = {
    require("aqara"),
    require("frient")
  },
  ias_zone_configuration_method = constants.IAS_ZONE_CONFIGURE_TYPE.AUTO_ENROLL_RESPONSE,
  default_ias_zone_configuration = ias_zone_configuration,

}

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

defaults.register_for_default_handlers(zigbee_smoke_driver_template, zigbee_smoke_driver_template.supported_capabilities)
local zigbee_smoke_driver = ZigbeeDriver("zigbee-smoke-detector", zigbee_smoke_driver_template)
log.trace(ias_zone_configuration)
log.trace(dump(constants.IAS_ZONE_CONFIGURE_TYPE))
zigbee_smoke_driver:run()
