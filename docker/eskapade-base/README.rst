kave/eskapade-base:latest
=========================

This directory contains the Dockerfile for ``kave/eskapade-base:latest`` which is the base image for ``kave/eskapade-usr:latest``.

The image ``kave/eskapade-base:latest`` is built on top of the `jupyter pyspark notebook <https://hub.docker.com/r/jupyter/pyspark-notebook/>`_ image,
which is well maintained, and contains ``pyspark``, ``scipy`` and ``jupyter``.

The Dockerfile installs an uptodate version of `ROOT <https://root.cern.ch>`_.
Warning, building this image takes a long time (about 1-2 hours).

Type:

  .. code-block:: bash

    $ docker pull kave/eskapade-base:latest

to pull it in from dockerhub.

