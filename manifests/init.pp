# ------------------------------------------------------------------------------
# Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------------

# Manages WSO2 Data Services Server deployment
class wso2dss (
  # wso2dss specific configuration data
  $taskServerCount        = $wso2dss::params::is_datasource,

  $packages               = $wso2dss::params::packages,
  $template_list          = $wso2dss::params::template_list,
  $file_list              = $wso2dss::params::file_list,
  $patch_list             = $wso2dss::params::patch_list,
  $cert_list              = $wso2dss::params::cert_list,
  $system_file_list       = $wso2dss::params::system_file_list,
  $directory_list         = $wso2dss::params::directory_list,
  $hosts_mapping          = $wso2dss::params::hosts_mapping,
  $java_home              = $wso2dss::params::java_home,
  $java_prefs_system_root = $wso2dss::params::java_prefs_system_root,
  $java_prefs_user_root   = $wso2dss::params::java_prefs_user_root,
  $vm_type                = $wso2dss::params::vm_type,
  $wso2_user              = $wso2dss::params::wso2_user,
  $wso2_group             = $wso2dss::params::wso2_group,
  $product_name           = $wso2dss::params::product_name,
  $product_version        = $wso2dss::params::product_version,
  $platform_version       = $wso2dss::params::platform_version,
  $carbon_home_symlink    = $wso2dss::params::carbon_home_symlink,
  $remote_file_url        = $wso2dss::params::remote_file_url,
  $maintenance_mode       = $wso2dss::params::maintenance_mode,
  $install_mode           = $wso2dss::params::install_mode,
  $install_dir            = $wso2dss::params::install_dir,
  $pack_dir               = $wso2dss::params::pack_dir,
  $pack_filename          = $wso2dss::params::pack_filename,
  $pack_extracted_dir     = $wso2dss::params::pack_extracted_dir,
  $patches_dir            = $wso2dss::params::patches_dir,
  $service_name           = $wso2dss::params::service_name,
  $service_template       = $wso2dss::params::service_template,
  $ipaddress              = $wso2dss::params::ipaddress,
  $enable_secure_vault    = $wso2dss::params::enable_secure_vault,
  $secure_vault_configs   = $wso2dss::params::secure_vault_configs,
  $key_stores             = $wso2dss::params::key_stores,
  $carbon_home            = $wso2dss::params::carbon_home,
  $pack_file_abs_path     = $wso2dss::params::pack_file_abs_path,

  # Templated configuration parameters
  $master_datasources     = $wso2dss::params::master_datasources,
  $registry_mounts        = $wso2dss::params::registry_mounts,
  $hostname               = $wso2dss::params::hostname,
  $mgt_hostname           = $wso2dss::params::mgt_hostname,
  $worker_node            = $wso2dss::params::worker_node,
  $usermgt_datasource     = $wso2dss::params::usermgt_datasource,
  $local_reg_datasource   = $wso2dss::params::local_reg_datasource,
  $clustering             = $wso2dss::params::clustering,
  $dep_sync               = $wso2dss::params::dep_sync,
  $ports                  = $wso2dss::params::ports,
  $jvm                    = $wso2dss::params::jvm,
  $fqdn                   = $wso2dss::params::fqdn,
  $sso_authentication     = $wso2dss::params::sso_authentication,
  $user_management        = $wso2dss::params::user_management
) inherits wso2dss::params {

  validate_string($taskServerCount)

  validate_hash($master_datasources)
  if $registry_mounts != undef {
    validate_hash($registry_mounts)
  }
  validate_string($hostname)
  validate_string($mgt_hostname)
  validate_bool($worker_node)
  validate_string($usermgt_datasource)
  validate_string($local_reg_datasource)
  validate_hash($clustering)
  validate_hash($dep_sync)
  validate_hash($ports)
  validate_hash($jvm)
  validate_string($fqdn)
  validate_hash($sso_authentication)
  validate_hash($user_management)

  class { '::wso2base':
    packages               => $packages,
    template_list          => $template_list,
    file_list              => $file_list,
    patch_list             => $patch_list,
    cert_list              => $cert_list,
    system_file_list       => $system_file_list,
    directory_list         => $directory_list,
    hosts_mapping          => $hosts_mapping,
    java_home              => $java_home,
    java_prefs_system_root => $java_prefs_system_root,
    java_prefs_user_root   => $java_prefs_user_root,
    vm_type                => $vm_type,
    wso2_user              => $wso2_user,
    wso2_group             => $wso2_group,
    product_name           => $product_name,
    product_version        => $product_version,
    platform_version       => $platform_version,
    carbon_home_symlink    => $carbon_home_symlink,
    remote_file_url        => $remote_file_url,
    maintenance_mode       => $maintenance_mode,
    install_mode           => $install_mode,
    install_dir            => $install_dir,
    pack_dir               => $pack_dir,
    pack_filename          => $pack_filename,
    pack_extracted_dir     => $pack_extracted_dir,
    patches_dir            => $patches_dir,
    service_name           => $service_name,
    service_template       => $service_template,
    ipaddress              => $ipaddress,
    enable_secure_vault    => $enable_secure_vault,
    secure_vault_configs   => $secure_vault_configs,
    key_stores             => $key_stores,
    carbon_home            => $carbon_home,
    pack_file_abs_path     => $pack_file_abs_path
  }

  contain wso2base
  contain wso2base::system
  contain wso2base::clean
  contain wso2base::install
  contain wso2base::configure
  contain wso2base::service

  Class['::wso2base'] -> Class['::wso2base::system']
  -> Class['::wso2base::clean'] -> Class['::wso2base::install']
  -> Class['::wso2base::configure'] ~> Class['::wso2base::service']
}