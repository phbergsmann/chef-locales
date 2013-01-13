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