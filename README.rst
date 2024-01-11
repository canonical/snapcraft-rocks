Snapcraft rocks
===============

This repository contains sources to generate `Snapcraft`_ `rocks`_. You can use
these sources to create OCI-compliant container images that run specific
versions of Snapcraft to create snaps.

The sources in this repository are capable of building different versions of
Snapcraft, targeting snaps for different cores. The sources are separated
into Git branches in the form ``coreX-Y``, where ``X`` is a core number (like
``22`` or ``24``), and ``Y`` is a major version of Snapcraft (like ``7`` or
``8``).

For example, branch ``core22-7`` contains the Rockcraft project to create
a rock containing the latest stable version of Snapcraft 7 and can be used
to create snaps targetting ``core22``.

Supported versions
------------------

These are the currently supported combinations of Snapcraft versions and cores:

- Branch ``core22-7``, for rocks with latest Snapcraft 7 to build ``core22``
  snaps.


Requirements
------------

- `Rockcraft`_ is needed to generate the rocks (minimum version ``1.1.0``).
- `Docker`_ or some other engine is needed to create containers from the images.

Instructions
------------

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
- Finally, use Docker to create containers to run Snapcraft. An important note
  here is that Snapcraft needs access to the directory containing the project
  that you want to snap (the directory containing the ``snap`` folder with a
  ``snapcraft.yaml`` file), and this directory needs to be exposed to the
  running container as ``/project``. For example, if the image was loaded into
  Docker as ``snapcraft-core22:latest``, the following command will mount the
  current directory into a new container and run ``snapcraft pack`` inside it::

    docker run --rm -it -v `pwd`:/project snapcraft-core22:latest pack

- Other commands, like ``clean`` or ``build``, can be called simply by replacing
  ``pack`` in the example above.


.. _rocks: https://canonical-rockcraft.readthedocs-hosted.com/en/latest/explanation/rocks/#rocks-explanation
.. _Snapcraft: https://www.snapcraft.io
.. _Rockcraft: https://github.com/canonical/rockcraft
.. _Docker: https://www.docker.com/
.. _Skopeo: https://github.com/containers/skopeo
.. _instructions: https://canonical-rockcraft.readthedocs-hosted.com/en/latest/tutorials/hello-world/#run-the-rock-in-docker
