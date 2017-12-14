
module MailData
  
  class ConnectMailHog

  	def self.get_data
  		Typhoeus::Request.new("http://0.0.0.0:8025/api/v2/messages").run
  	end

  	def self.serach_data(url, kind, term)
  		Typhoeus::Request.new(url, method: :get, params: {"kind" => kind, "query"=>term}).run
  	end

  	def self.delete_data(url)
  		Typhoeus::Request.new(url, method: :delete).run
  	end

  end

end