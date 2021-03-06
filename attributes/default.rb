#
# Cookbook Name:: ntp
# Attributes:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["ntp"]["packages"] = %w(
  ntp
)

default["ntp"]["servers"] = %w(
  0.de.pool.ntp.org
  1.de.pool.ntp.org
  2.de.pool.ntp.org
  3.de.pool.ntp.org
)

default["ntp"]["service_name"] = value_for_platform_family(
  "debian" => "ntp",
  "suse" => value_for_platform(
    "opensuse" => {
      "< 13.2" => "ntp",
      "default" => "ntpd"
    },
    "opensuseleap" => {
      "default" => "ntpd"
    },
    "suse" => {
      "< 12" => "ntp",
      "default" => "ntpd"
    }
  )
)

default["ntp"]["sysconfig_file"] = value_for_platform_family(
  "debian" => "/etc/default/ntp",
  "suse" => "/etc/sysconfig/ntp"
)

default["ntp"]["config_file"] = "/etc/ntp.conf"
default["ntp"]["listen"] = "127.0.0.1"
default["ntp"]["log_file"] = "/var/log/ntp"

default["ntp"]["drift_file"] = value_for_platform_family(
  "debian" => "/var/lib/ntp/ntp.drift",
  "suse" => "/var/lib/ntp/drift/ntp.drift"
)

default["ntp"]["stats_dir"] = "/var/log/ntpstats"
default["ntp"]["owner"] = "ntp"
default["ntp"]["group"] = "ntp"
