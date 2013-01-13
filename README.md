Description
===========

This cookbook configures the available and default locales on a debian-like-system.
It also includes a LWRP for easy use in other cookbooks.

Requirements
============

None

Attributes
==========

* `node[:locales][:available]` -- the locales to be installed. Defaults to "en_US.UTF-8 UTF-8".
* `node[:locales][:default]` -- the default locale to be installed. Defaults to "en_US.UTF-8".

Usage
=====

Either use the node-attributes or the included LWRP "locales".

```ruby
locales "de_AT.UTF-8 UTF-8" do
	action :add
end
```

License and Author
==================

Author: Philipp Bergsmann (<p.bergsmann@opendo.at>)

Copyright: 2013 opendo GmbH (http://opendo.at)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.