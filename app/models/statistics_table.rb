class StatisticsTable

	##	Table type example:
	##				User_type	|	Number_of_Male |	Number_of_Female
	##
	##				Admin			|				4				 |				3
	##				Normal		|			 24			 	 |			 33
	##

	def initialize
		@headers = []	
		@lines = []
		@title = 'Title'
		@axis_title = 'Axis'
		@summary = 'Table de stats'
		@caption = 'Empty Caption'
		@x_label = []
		@x_label_url_params = ''
		@min_value = 0
		@max_value = 0
		@header_names = []
		@number_of_row = 0
		@number_of_column = 0
		@data_per_row = []
		@data_per_column = []
	end

	
	## Parameters: 
	##				type is a String which determines the type of the data of the column
	##				name is a String which is the name which will appear in the table
	##				Example:
	##						addHeader('string','Car')
	
	def add_header(type, name)
		hash = {}
		hash[:type] = type
		hash[:name] = name
		@headers << hash
		if type == "number"
			add_header_name(name)
		end
		@number_of_column = @number_of_column + 1
		@data_per_column << []
	end
	
	## Parameter line is an array containing the data for a line
	## Example: 
	## 			Say we have this header: 
	## 						Car, Color => @headers = ([['string', 'Car'],['string', 'Color']]
	## 
	##						line will be like ['Chrysler','Blue']
	
	def add_line(line)
		if line.length == @headers.length
			@lines << line
			add_x_label(line[0])
			temp_value_for_row = []
			line.each_with_index do |l, i|
				if i != 0	
					set_max_value(l)
					temp_value_for_row << l		
					@data_per_column[i - 1] << l
				end
			end
			@data_per_row << temp_value_for_row
			@temp_value_for_row = []
			@number_of_row = @number_of_row + 1
		end
	end
	
	def title=(title)
		@title = title
	end
	
	def axis_title=(title)
		@axis_title = title
	end
	
	def summary=(summary)
		@summary = summary
	end
	
	def caption=(caption)
		@caption
	end
	
	### Getters ###
	def title
		@title
	end
	
	def headers
		@headers
	end

	def lines
		@lines
	end
	
	def number_of_lines
		@lines.length
	end
		
	def axis_title
		@axis_title
	end
	
	def summary
		@summary
	end
	
	def caption
		@caption
	end
	
	def x_label
		 @x_label
	end
	
	def max_value
		@max_value
	end
	def min_value
		@min_value
	end
	
	def header_names 
		@header_names 
	end
	
	def data_per_row
		@data_per_row
	end
	
	def data_per_column
		@data_per_column
	end
	
	def number_of_row 
		@number_of_row
	end
	
	def x_label_url_params
		@x_label_url_params
	end
	private 
		def add_x_label(label)
			@x_label << label
			if @x_label.length > 1
				@x_label_url_params += '|' + label
			else
				@x_label_url_params += label
			end
		end
		
		def set_max_value(value)
			if @max_value < value
				@max_value = value
			end	 	
		end
		def set_min_value(value)
			if @min_value > value
				@min_value = value
			end
		end	
		def add_header_name(header_name)
			@header_names << header_name.to_s
		end
		
		def number_of_row=(number_of_row)
			@number_of_row = number_of_row
		end
		
		def add_row
			@number_of_row = @number_of_row + 1
		end
end