Longshoreman Cookbook
=====================
A cookbook for creating a remote build server based on Docker.

Goal
----
I want faster tests! But I also want to host as little of my own build
environment as possible!

`kitchen-docker` and `kitchen-docker-api` are awesome, but Docker on its own
relies on an unencrypted API connection. What if a proxy with HTTPS + auth
could sit in front of Docker and Docker used a caching proxy during builds?

Components
----------
* Docker - The container manager itself
* Reverse proxy(?)

FAQ
---
***What's up with Nginx?***

Nginx is awesome, but apparently its buffering (even when ostensibly disabled)
[may not play well](https://gist.github.com/RoboticCheese/11389800) with
applications that use chunked transfer encoding in their HTTP responses.
Debugging it ate up time to the point of my nearly abandoning it before the
issue vanished and I haven't been able to reproduce it since.

To Do
-----
* TODO: Networking from the native Docker daemon to the Nginx container isn't
working
* TODO: Proxying to a Unix socket for package-based installs and a TCP socket
for container-based installs is ugly and inconsistent. Should this be unified?
* TODO: Look into other possible reverse proxies, especially if the buffering
issue resurfaces
    * Pound?
    * HAProxy?
    * Squid?
    * Vulcan - No HTTPS or auth support

License & Authors
-----------------
- Author: Jonathan Hartman <j@p4nt5.com>

Copyright 2014, Jonathan Hartman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
