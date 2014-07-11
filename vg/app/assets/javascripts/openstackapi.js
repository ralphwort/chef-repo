function update_server_status(openstack_user_id, node_name)
{
	$.get("openstack_actions/server_status?openstack_user=" + openstack_user_id + "&node_name=" + node_name, function(data)
    {
      $('#' + node_name).html(data);
    	previous_start = $('#start_' + node_name).html();
      if (data.indexOf("Gone") !=-1) {
      	$('#start_go_' + node_name).show();
      	$('#start_stop_' + node_name).hide();
      	$('#volume_go_' + node_name).hide();
      	$('#volume_stop_' + node_name).show();
      	$('#ipaddress_go_' + node_name).hide();
      	$('#ipaddress_stop_' + node_name).show();
      	$('#control_go_' + node_name).hide();
      	$('#control_stop_' + node_name).show();
      }
      else
      {
      	$('#start_go_' + node_name).hide();
      	$('#start_stop_' + node_name).show();
      	$('#volume_go_' + node_name).show();
      	$('#volume_stop_' + node_name).hide();
      	$('#ipaddress_go_' + node_name).show();
      	$('#ipaddress_stop_' + node_name).hide();
      	$('#control_go_' + node_name).show();
      	$('#control_stop_' + node_name).hide();
      }
    });
}
