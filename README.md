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
* Caching layer

To Do
-----
* TODO: Wait a minute... Docker has
[HTTPS](http://docs.docker.io/examples/https/) now?! Is that new?

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
