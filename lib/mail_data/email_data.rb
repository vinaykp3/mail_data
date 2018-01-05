module MailData
	
	class EmailData
		
		def initialize(url, term, query)
			@url = url
			@term = term
			@query = query
		end

		def data
			data = search
			user_mail = data['items'].find{|mail| mail['Content']['Headers']['Subject'] == [@query] }
			return format_data(user_mail) if user_mail
			{}
		end

		def format_data(data)
			{
				from: data['Content']['Headers']['From'].first.delete('\\"'),
				to: data['Content']['Headers']['To'].first,
				subject: data['Content']['Headers']['Subject'].first,
				content: formatted_content(data['MIME'])
			}
		end

		def formatted_content(data)
			data_parts = data['Parts']
			data_parts.shift;data_parts.pop;
			data_parts.inject([]){ |prepared_data, part| prepared_data << prepare_data(part);prepared_data }
		end

		def prepare_data(part)
			{
				"#{part['Headers']['Content-Type'].first.split(';').first}" => part['Body']
			}
		end


		def search
			url = "#{@url}/api/v2/search"
			data = MailData::ConnectMailHog.serach_data(url, 'to', @term)
			JSON.parse(data.body)
		end

	end

end