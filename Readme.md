Zerigo DNS Checker
======
check_dns.rb verifies DNS records for the given Zerigo zone (domain).  Currently this just means it tries to ping A
records and shows success/failure. :)

## Usage
```
git clone git@github.com:jguice/zerigo-dns-checker.git
bundle install
bundle exec ./check_dns.rb 
```

**NOTE:** you'll probably need to run this with sudo as shown in the example for the pings to work.
