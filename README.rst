Snapcraft rocks
===============

`Snapcraft`_ `rocks`_ are OCI-compliant container images with different
versions of Snapcraft to create snaps.

Each rock in this repository bundles a specific version of Snapcraft, targeting
snaps for a specific core. The currently supported versions and cores have the
following tags:

- ``7_core22``, bundling the latest Snapcraft 7 capable of building ``core22``
  snaps.
- ``8_core22``, bundling the latest Snapcraft 8 capable of building ``core22``
  snaps.
- ``8_core24``, bundling the latest Snapcraft 8 capable of building ``core24``
  snaps.

This repository contains sources for generating images.

* `core22-7 <https://github.com/canonical/snapcraft-rocks/tree/core22-7>`_
* `core22-8 <https://github.com/canonical/snapcraft-rocks/tree/core22-8>`_
* `core24-8 <https://github.com/canonical/snapcraft-rocks/tree/core24-8>`_

And repository of built container images.

* https://github.com/canonical/snapcraft-rocks/pkgs/container/snapcraft


Usage
-----

The contained Snapcraft needs access to the directory containing the project
that you want to snap (the directory containing the ``snap`` folder with a
``snapcraft.yaml`` file), and this directory needs to be exposed to the
running container as ``/project``. For example, the following command will
mount the current directory into a new container and run ``pack`` on the
latest version of Snapcraft 8 for core24 snaps::

  docker run -it -v `pwd`:/project ghcr.io/canonical/snapcraft:8_core24 pack

Other commands, like ``clean`` or ``build``, can be called simply by replacing
``pack`` in the example above. Every argument provided after the image name is
forwarded to Snapcraft.

To see `snapcraft` output, add flags::

  docker run -it -v `pwd`:/project ghcr.io/canonical/snapcraft:8_core24 \; -v


Reporting bugs
--------------

Please report all issues, improvements and feature requests at
https://github.com/canonical/snapcraft-rocks.


Development
-----------

The sources in this repository are capable of building different versions of
Snapcraft, targeting snaps for different cores. The sources are separated
into Git branches in the form ``coreX-Y``, where ``X`` is a core number (like
``22`` or ``24``), and ``Y`` is a major version of Snapcraft (like ``7`` or
``8``).

For example, branch ``core22-7`` contains the Rockcraft project to create
a rock containing the latest stable version of Snapcraft 7 and can be used
to create snaps targetting ``core22``.

Supported versions
~~~~~~~~~~~~~~~~~~

These are the currently supported combinations of Snapcraft versions and cores:

- Branch ``core22-7``, for rocks with latest Snapcraft 7 to build ``core22``
  snaps.
- Branch ``core22-8``, for rocks with latest Snapcraft 8 to build ``core22``
  snaps.
- Branch ``core24-8``, for rocks with latest Snapcraft 8 to build ``core24``
  snaps.


Requirements
~~~~~~~~~~~~

- `Rockcraft`_ is needed to generate the rocks (minimum version ``1.1.0``).
- `Docker`_ or some other engine is needed to create containers from the images.
  **Note**: Docker can sometimes make ``iptables`` changes that break LXD
  instances used by Rockcraft. See `this page`_ for details.

Instructions
~~~~~~~~~~~~

- First, choose a target Snapcraft version and core and checkout the appropriate
  branch. As an example, let's use branch ``core22-7``.
- Run ``rockcraft pack`` to create a rock whose name starts with
  ``snapcraft-core22_7``. The remainder of the name depends on the actual full
  version of Snapcraft and the host architecture. For example, running this
  command on an ``amd64`` machine when ``7.5.4`` is the latest stable Snapcraft
  7 version will yield a rock called ``snapcraft-core22_7.5.4_amd64.rock``.
- Use a tool like `Skopeo`_ to convert and load the rock into Docker's local
  registry. You can use the ``skopeo`` binary included in Rockcraft's snap for
  this (see the `instructions`_ on Rockcraft's docs).
- Finally, use Docker to create containers to run Snapcraft as described in the
  `Usage`_ section above.

.. _rocks: https://canonical-rockcraft.readthedocs-hosted.com/en/latest/explanation/rocks/#rocks-explanation
.. _Snapcraft: https://www.snapcraft.io
.. _Rockcraft: https://github.com/canonical/rockcraft
.. _Docker: https://www.docker.com/
.. _Skopeo: https://github.com/containers/skopeo
.. _instructions: https://canonical-rockcraft.readthedocs-hosted.com/en/latest/tutorials/hello-world/#run-the-rock-in-docker
.. _this page: https://canonical-craft-providers.readthedocs-hosted.com/en/latest/explanation/#failure-to-properly-execute-commands-that-depend-on-network-access
