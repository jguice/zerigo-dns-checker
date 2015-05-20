Zerigo DNS Checker
======
check_dns.rb verifies DNS records for the given Zerigo zone (domain).  Currently this just means it tries to ping A
records and shows success/failure. :)

## Usage
```
git clone git@github.rackspace.com:josh8649/zerigo-dns-checker.git
bundle install
bundle exec ./check_dns.rb # note you'll probably need to run it with sudo as shown in the example
```
