public class SL1GetAssetHandler implements SL1Request.Handler  {
    public static Map<String, String> fieldMap = new Map<String, String>{
        'ip' => 'ip',
        'name' => 'name'
    };
        

    final public SL1Job__c job;
    public SL1GetAssetHandler(SL1Job__c job) {
        this.job = job;
    }
    public void handle(Map<String, Object> json1, SL1Connection connection, SL1Request request) {
        Map<String, Object> agentPost = new Map<String, Object>{
            'body' => new Map<String, Object>{
                'Hardware' => new Map<String, Object>{
                    'data' => new Map<String, Object>{
                        'id' => request.path,
                        'external_ip' => (String)json1.get('ip'),
                        'name' => (String)json1.get('name'),
                        'object_hash' => (String)json1.get('inf_hash')
                    }
                }
            }
        };
        this.job.Result__c = JSON.serialize(agentPost);
    }
}


/*
example json:
{
   name: 'WIN-OT0BJUSQFL8.demolab.local',
   ip: '172.16.12.210',
   hostname: null,
   snmp_cred_id: '/api/credential/snmp/64',
   snmp_w_cred_id: null,
   class_type: '/api/device_class/3102',
   collector_group: '/api/collector_group/1',
   active: [Object],
   organization: '/api/organization/0',
   auto_update: '1',
   event_suppress_mask: '00:10:00',
   auto_clear: '1',
   log_all: '1',
   daily_port_scan: '1',
   critical_ping: '0',
   agent_prime_backend: null,
   agent_os: null,
   scan_all_ips: '0',
   preserve_hostname: '1',
   disable_asset_update: '0',
   date_added: '1481322220',
   alert_avail_and_latency_fail: '0',
   l3_topo: null,
   updated_by: '/api/account/1',
   edit_date: '1481322220',
   dashboard: null,
   interface_inventory_timeout: '600000',
   max_interface_inventory_count: '10000',
   bypass_interface_inventory: '0',
   inf_hash: 'f55d2c75d8fc02d7eca94030358c32a89c1eada58535316a0c300113e4c26241',
   agent_guid: null,
   parent_device: null,
   child_devices: [],
   state: '3',
   last_poll: '1539514500',
   notes: [Object],
   logs: [Object],
   applications: [Object],
   performance_data: [Object],
   config_data: [Object],
   vitals: [Object],
   interfaces: [Object],
   thresholds: [Object],
   details: [Object],
   app_credentials: [Object]
 }
 */