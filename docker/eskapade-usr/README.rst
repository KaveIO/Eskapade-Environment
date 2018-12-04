kave/eskapade-usr:latest
========================

This directory contains the Dockerfile for ``kave/eskapade-usr:latest``, the standard docker image for Eskapade.

It is built on top of ``kave/root:latest``, which is itself built on top of the `jupyter pyspark notebook <https://hub.docker.com/r/jupyter/pyspark-notebook/>`_ image,
which is well maintained. The image contains ``pyspark``, ``scipy``, ``jupyter`` and ``ROOT``.

Type:

  .. code-block:: bash

    $ docker pull kave/eskapade-usr:latest

to pull it in from dockerhub.

