Snapcraft rocks
===============

`Snapcraft <https://www.snapcraft.io>`_ `rocks <https://canonical-rockcraft.readthedocs-hosted.com/en/latest/explanation/rocks/#rocks-explanation>`_ are OCI-compliant container images with different versions of Snapcraft to create snaps.

Each rock in this repository bundles a specific version of Snapcraft, targeting
snaps for a specific core. The currently supported versions and cores have the
following tags:

- ``9_core22``, bundling the latest Snapcraft 9 capable of building ``core22``
  snaps.
- ``9_core24``, bundling the latest Snapcraft 9 capable of building ``core24``
  snaps.
- ``9_core26``, bundling the latest Snapcraft 9 capable of building ``core26``
  snaps.

The sources and tests for the rocks live in the ``rocks/`` directory:

* `rocks/core22_9 <https://github.com/canonical/snapcraft-rocks/tree/main/rocks/core22_9>`_
* `rocks/core24_9 <https://github.com/canonical/snapcraft-rocks/tree/main/rocks/core24_9>`_
* `rocks/core26_9 <https://github.com/canonical/snapcraft-rocks/tree/main/rocks/core26_9>`_

And repository of built container images.

* https://github.com/canonical/snapcraft-rocks/pkgs/container/snapcraft


Usage
-----

The contained Snapcraft needs access to the directory containing the project
that you want to snap (the directory containing the ``snap`` folder with a
``snapcraft.yaml`` file), and this directory needs to be exposed to the
running container as ``/project``. For example, the following command will
mount the current directory into a new container and run ``pack`` on the
latest version of Snapcraft 9 for core24 snaps::

  docker run -it -v `pwd`:/project ghcr.io/canonical/snapcraft:9_core24 pack

Other commands, like ``clean`` or ``build``, can be called simply by replacing
``pack`` in the example above. Every argument provided after the image name is
forwarded to Snapcraft.

To see `snapcraft` output, add flags::

  docker run -it -v `pwd`:/project ghcr.io/canonical/snapcraft:9_core24 \; -v


Reporting bugs
--------------

Please report all issues, improvements and feature requests at
https://github.com/canonical/snapcraft.


Development
-----------

The sources in this repository build different versions of Snapcraft, targeting
snaps for different cores. Each rock lives in a self-contained directory under
``rocks/``, named ``coreX_Y``, where ``X`` is a core number (like ``22`` or
``24``) and ``Y`` is a major version of Snapcraft (like ``9``).

For example, ``rocks/core26_9`` contains the Rockcraft project to create a rock
containing the latest stable version of Snapcraft 9, used to create snaps
targeting ``core26``.

Supported versions
~~~~~~~~~~~~~~~~~~

These are the currently supported combinations of Snapcraft versions and cores:

- Directory ``rocks/core22_9``, for rocks with latest Snapcraft 9 to build
  ``core22`` snaps.
- Directory ``rocks/core24_9``, for rocks with latest Snapcraft 9 to build
  ``core24`` snaps.
- Directory ``rocks/core26_9``, for rocks with latest Snapcraft 9 to build
  ``core26`` snaps.

Requirements
~~~~~~~~~~~~

- `Rockcraft <https://github.com/canonical/rockcraft>`_ is needed to generate the rocks.
- `Docker <https://www.docker.com/>`_ or some other engine is needed to create containers from the images.
  **Note**: Docker can sometimes make ``iptables`` changes that break LXD
  instances used by Rockcraft. See `this page <https://canonical-craft-providers.readthedocs-hosted.com/en/latest/explanation/#failure-to-properly-execute-commands-that-depend-on-network-access>`_ for details.

Building and testing
~~~~~~~~~~~~~~~~~~~~

Each rock is built and tested with a single command from its directory. For
example, to build and test the core26 rock with Snapcraft 9::

  cd rocks/core26_9
  ROCKCRAFT_EXPERIMENTAL_MONOREPO=1 rockcraft test

``rockcraft test`` packs the rock and then runs the
`spread <https://github.com/canonical/spread>`__ tests in ``tests/spread/`` using
the ``craft`` backend.

To pack the rock without running tests::

  ROCKCRAFT_EXPERIMENTAL_MONOREPO=1 rockcraft pack

To run a subset of tests, pass a spread test expression::

  ROCKCRAFT_EXPERIMENTAL_MONOREPO=1 rockcraft test tests/spread/general/hello

Use a tool like `Skopeo <https://github.com/containers/skopeo>`_ to convert and load the rock into Docker's local registry.
You can use the ``skopeo`` binary included in Rockcraft's snap for this (see the
`instructions <https://canonical-rockcraft.readthedocs-hosted.com/en/latest/tutorials/hello-world/#run-the-rock-in-docker>`_ on Rockcraft's docs). Finally, use Docker to create containers to run
Snapcraft as described in the `Usage`_ section above.

Publishing
~~~~~~~~~~

Rocks are published by CI on every push to ``main``. Each rock is published as a
multi-architecture image to the GitHub Container Registry with a tag of the form
``<snapcraft-version-series>_<core>``, derived from the directory name. For
example, ``rocks/core26_9`` publishes ``ghcr.io/canonical/snapcraft:9_core26``.
