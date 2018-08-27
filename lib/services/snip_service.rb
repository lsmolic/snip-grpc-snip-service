require 'grpc'
require 'snip_services_pb'
require 'bop_services_pb'

class SnipService < Snip::UrlSnipService::Service
	def snip_it(snip_req, _unused_call)
		puts "Received URL snip request for #{snip_req.url}"
		stub = Bop::BopService::Stub.new('bop:50053', :this_channel_is_insecure)
		req = Bop::BopRequest.new(url: snip_req.url)
		resp_obj = stub.bop_it(req)

		Snip::SnipResponse.new(url: resp_obj.url)
		# Snip::SnipResponse.new(url: snip_req.url)
	end
end

