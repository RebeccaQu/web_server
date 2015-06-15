require 'socket'

host = 'localhost'	#127.0.0.1 (my own computer)
port = 2000

server = TCPServer.open(host, port)
puts "Server started on #{host}: #{port} ..."

loop do 
	client = server.accept

	lines = []
	while (line = client.gets) && !line.chomp.empty?
		lines << line.chomp
	end
	puts lines

	filename = lines[0].gsub(/GET \//, "").gsub(/ HTTP\/1.1/, "")
	
	if File.exists?(filename)
		body = File.read(filename)
	else
		body = "File not found"
	end


	client.puts(body)
	client.close
end

