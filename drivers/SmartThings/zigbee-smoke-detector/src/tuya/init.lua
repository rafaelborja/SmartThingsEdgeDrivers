-- Copyright 2021 SmartThings
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
local battery_defaults = require "st.zigbee.defaults.battery_defaults"

local is_tuya_smoke_detector = function(opts, driver, device)
  if device:get_model() == "TS0205_" then
    log.trace("Tuya Subdriver for model TS0205 loaded")
    return true
  end
  return false
end

local frient_smoke_detector = {
  NAME = "Tuya Smoke Detector",
  lifecycle_handlers = {
    init = battery_defaults.build_linear_voltage_init(2.3, 3.0)
  },
  can_handle = is_frient_smoke_detector
}

return frient_smoke_detector
