-- Create an ConfigMap from this file.
-- kubectl create configmap fluent-bit-lua --from-file=luascript=fluent_bit.lua
function append_tenant_info(tag, timestamp, record)
	new_record = record
	data=record["log"]
	tenant_id=data:match("GET /([^/]+)/v1")
	if tenant_id == nil then
		tenant_id=data:match("POST /([^/]+)/v1")
	end
	if tenant_id == nil then
		tenant_id=data:match("PATCH /([^/]+)/v1")
	end
	if tenant_id == nil then
		tenant_id=data:match("PUT /([^/]+)/v1")
	end
	if tenant_id == nil then
		tenant_id=data:match("DELETE /([^/]+)/v1")
	end
	if tenant_id ~= nil then
		new_record["tenant_id"] = tenant_id
		store_id=data:match("/v1/stores/([^/]+)/")
		if store_id ~= nil then
			new_record["store_id"] = store_id
		end
	end
    return 1, timestamp, new_record
end