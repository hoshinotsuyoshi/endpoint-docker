path = '/etc/sensu/config.json'
string = File.read(path)
string = string.gsub(/\$SENSU_SERVER_HOST/, ENV['SENSU-SERVER_PORT_5672_TCP_ADDR'])
File.open(path, 'w'){|f| f.write string}
