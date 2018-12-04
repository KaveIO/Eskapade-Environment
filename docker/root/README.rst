kave/root:latest
================

This directory contains the Dockerfile for ``kave/root:latest`` which is the base image for ``kave/eskapade-usr:latest``.

The image ``kave/root:latest`` is built on top of the `jupyter pyspark notebook <https://hub.docker.com/r/jupyter/pyspark-notebook/>`_ image,
which is well maintained, and contains ``pyspark``, ``scipy`` and ``jupyter``.

The Dockerfile installs an uptodate version of `ROOT <https://root.cern.ch>`_.
Warning, building this image takes a long time (about an hour).

Type:

  .. code-block:: bash

    $ docker pull kave/root:latest

to pull it in from dockerhub.

