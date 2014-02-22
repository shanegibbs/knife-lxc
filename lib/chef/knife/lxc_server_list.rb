require 'chef/knife'
require 'toft'
require 'yaml'

module KnifeLxc

  class LxcServerList < Chef::Knife

    banner 'knife lxc server list'

    include Toft

    # This method will be executed when you run this knife command.
    def run
      puts 'Lxc containers list'
      containers = `sudo lxc-ls`.split.uniq
      server_list = [
        ui.color('Name', :bold),
        ui.color('State', :bold),
        ui.color('Ip', :bold)
      ]

      ip_address_map = get_ip_address_map
      state_map = get_state_map(containers)

      containers.each do |container|
        server_list << container
        server_list << state_map[container]
        server_list << ip_address_map[container]
      end

      puts ui.list(server_list, :uneven_columns_across, 3)
    end

    private

    def get_ip_address_map
      map = Hash.new

      leases_path = '/var/lib/misc/dnsmasq.leases'
      File.read(leases_path).split("\n").each do |lease|
        cols = lease.split(' ')
        map[cols[3]] = cols[2]
      end if File.exist?(leases_path)

      map
    end

    def get_state_map(containers)
      map = Hash.new

      containers.each do |container|
        result = `sudo lxc-info --state --name #{container}`
        # puts result

        if match = result.match(/state: *(.+)/i)
          state = match.captures.first.downcase
          map[container] = state if state != 'stopped'
        end

      end

      map
    end

  end
end
