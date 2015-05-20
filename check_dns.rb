#!/usr/bin/env ruby

require_relative 'zerigo_dns'
require_relative 'stupid_things'

require 'pp'
require 'net/ping'

Zerigo::DNS::Base.user = ENV['ZERIGO_USER']
Zerigo::DNS::Base.api_key = ENV['ZERIGO_API_KEY']

unless ARGV[0] && ENV['ZERIGO_USER'] && ENV['ZERIGO_API_KEY']
  puts "Checks a zerigo dns zone (domain) for A records that point to invalid hosts"
  puts "Usage: check_dns.rb <domain>"
  puts "Example: sudo -E bundle exec ./check_dns.rb k1k.me (sudo needed by net/ping)"
  puts "Note you must export ZERIGO_USER and ZERIGO_API_KEY environment variables or this message will be displayed"
  exit 0
end

# without this Net::Ping keeps trying the next one :/
trap "SIGINT" do
  puts "Bye!"
  puts "suicide ##{Process.pid}"
  exec("kill -9 #{Process.pid}")
end

def ping(host, name=nil)
  pinger = Net::Ping::ICMP.new()

  puts "#{host} [#{name}] #{pinger.ping(host) ? 'ok' : 'failed'}"
  STDOUT.flush # make sure we see the output right away :)
end

zone_name = ARGV[0]

zone = Zerigo::DNS::Zone.find(zone_name)

if zone.nil?
  puts "zone #{zone_name} not found..."
  exit 1
end

hosts = Zerigo::DNS::Host.all(:zone_id => zone.id, :per_page => 9999, :page => 1)

ping_threads = Hash.new

hosts.each do |host|
  if host.host_type == 'A'

    ping_threads[host.data] = Thread.new { ping(host.data, host.fqdn) }
  end

  sleep(0.1) # slow down to prevent exhaustion (too lazy to chunk work just yet)
end

ping_threads.each{ |host, thread| thread.join }
