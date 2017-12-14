module MailData
	class MailHogClient
		
		def initialize(client_url)
			@url = client_url
		end

		def find_message(term, query)
			MailData::EmailData.new(@url, term, query).data
		end

		def delete_all_mails
			url = "#{@url}/api/v1/messages"
			MailData::ConnectMailHog.delete_data(url)
		end

	end
end