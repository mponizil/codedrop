os = require 'os'

networks = os.networkInterfaces()
addresses = []

for name, network of networks
  for address in network
    if address.family is 'IPv4' and not address.internal
      addresses.push address.address

exports.addresses = addresses
