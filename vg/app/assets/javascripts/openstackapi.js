function update_server_status(openstack_user_id, node_name)
{
	$.get("openstack_actions/server_status?openstack_user=" + openstack_user_id + "&node_name=" + node_name, function(data)
    {
      $('#' + node_name).html(data);
    });
}
