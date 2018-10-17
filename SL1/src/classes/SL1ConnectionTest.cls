@isTest
private class SL1ConnectionTest {
  public class SL1RequestMockImpl implements HttpCalloutMock {
      public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"searchspec":{"fields":["_id","active","agent_guid","agent_os","agent_prime_backend","alert_avail_and_latency_fail","auto_clear","auto_update","bypass_interface_inventory","class_type","class_type/class","class_type/description","class_type/device_category/cat_name","class_type/device_category/guid","class_type/guid","class_type/logical_name","collector_group","collector_group/cug_name","component_ancestor_device","component_parent_device","component_root_device","component_unique_id","critical_ping","daily_port_scan","dashboard","date_added","device_group","disable_asset_update","edit_date","event_suppress_mask","hostname","inf_hash","interface_inventory_timeout","ip","l3_topo","last_poll","log_all","max_interface_inventory_count","merged_class_type/class","merged_class_type/description","merged_class_type/device_category/cat_name","merged_class_type/device_category/guid","merged_class_type/guid","merged_class_type/logical_name","name","organization","organization/company","preserve_hostname","scan_all_ips","snmp_cred_id","snmp_w_cred_id","state","updated_by"],"options":{"hide_filterinfo":{"type":"boolean","description":"Suppress filterspec and current filter info if 1 (true)","default":"0"},"limit":{"type":"int","description":"Number of records to retrieve","default":"100"},"offset":{"type":"int","description":"Specifies the index of the first returned resource within the entire result set","default":"0"},"extended_fetch":{"type":"boolean","description":"Fetch entire resource if 1 (true), or resource link only if 0 (false)","default":"0"},"link_disp_field":{"type":"enum","description":"When not using extended_fetch, this determines which field is used for the \\"description\\" of the resource link","default":"name","values":["state","last_poll","class_type/guid","class_type/class","class_type/logical_name","class_type/description","class_type/device_category/guid","class_type/device_category/cat_name","merged_class_type/guid","merged_class_type/class","merged_class_type/description","merged_class_type/logical_name","merged_class_type/device_category/guid","merged_class_type/device_category/cat_name","organization/company","device_group","component_unique_id","component_root_device","component_parent_device","component_ancestor_device","collector_group/cug_name","name","ip","hostname","snmp_cred_id","snmp_w_cred_id","class_type","collector_group","active","organization","auto_update","event_suppress_mask","auto_clear","log_all","daily_port_scan","critical_ping","agent_prime_backend","agent_os","scan_all_ips","preserve_hostname","disable_asset_update","date_added","alert_avail_and_latency_fail","l3_topo","updated_by","edit_date","dashboard","interface_inventory_timeout","max_interface_inventory_count","bypass_interface_inventory","inf_hash","agent_guid"]}}},"total_matched":11,"total_returned":2,"result_set":[{"URI":"/api/device/435","description":"win1.demo.sciencelogic.local"},{"URI":"/api/device/1","description":"zenith1.f5se.com"}]}');
        res.setStatusCode(200);
        return res;
      }
  }

  @isTest
  static void testRefreshDevices() {
    Test.setMock(HttpCalloutMock.class, new SL1RequestMockImpl());
    Test.startTest();
    SL1Test.refreshDevices(null);
    Test.stopTest();
  }
}
