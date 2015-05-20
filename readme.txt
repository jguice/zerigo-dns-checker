Zerigo DNS - REST API - Ruby library
====================================

Thanks for downloading the Zerigo DNS REST API Ruby library. This library
comes in two flavors, both included here. The first requires the 
ActiveResource gem which is a part of Rails. The second requires the 
resource_party gem instead (which in turn depends on HTTParty). We 
recommend the resource_party version for everyone except those
already using Rails. Included here are the following files:

 readme.txt - this document
 sample_ares.rb - a simple example showing how to use the ActiveResource 
     version of the library
 sample.rb - a simple example showing how to use the resource_party version
     of the library
 zerigo_ns.rb - the actual library, ActiveResource version
 activeresource-ext.rb - ActiveResource extensions that are required by 
     zerigo_ns.rb
 zerigo_dns.rb - the actual library, resource_party version
 MIT-LICENSE - the license and terms for this library

The API documentation itself is not provided here. The latest version can
be found online at http://www.zerigo.com/docs/managed-dns/api_11.


Requirements
------------
The following are required to use this library:

- A functioning Ruby environment with HTTP (or HTTPS) access to the internet.
  - Our tests were conducted with Ruby 1.8.6.
- Additionally, you will need either ActiveResource or HTTParty.
  - We have tested with ARes 2.3.2.
  - We have tested with resource_party 0.2.0 and HTTParty 0.4.4.
    - gem install jeffrafter-resource_party 
      (requires rubygems to have github as a source)
- Some working knowledge of the Ruby language.
- A Zerigo DNS account with Dynamic Updates / API Access enabled. (Visit
  https://ns.zerigo.com/ and go to Preferences to enable access.)
- The Dynamic Update / API key. (Also available on the Preferences page.)


Use
---
The example usage code (sample_ares.rb and sample.rb) are heavily commented.
They should serve as sufficient reference for this code.


Updates
-------
Visit http://www.zerigo.com/docs/managed-dns for updates, new versions, and
more.


Support
-------
Support is generally available via standard Zerigo support options. See
http://www.zerigo.com/support for more information. Please note that support
may be limited based on your choice of Zerigo DNS services.


Comments / Suggestions
----------------------
We always welcome comments, suggestions, and constructive complaints. You can
find several ways to contact us at http://www.zerigo.com/contact.


Copyright & Warranty
--------------------
All Zerigo documentation, libraries, and sample code are 
Copyright 2010 Zerigo, Inc. The library and sample code are made available to
you under the terms of the MIT license which is contained in the included 
file, MIT-LICENSE.

The Zerigo name and Zerigo logo are trademarks of Zerigo, Inc. and may not be
used without permission.

The terms here grant you no rights in regard to the Zerigo services. Please
reference Zerigo's Terms of Service for all legal information regarding
Zerigo's services.
