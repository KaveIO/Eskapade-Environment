====================
Eskapade-Environment
====================

* Version: 0.9.0
* Released: Dec 2018

Eskapade is a light-weight, python-based data analysis framework, meant for modularizing all sorts of data analysis problems
into reusable analysis components. For documentation on Eskapade, please go to this `link <http://eskapade.readthedocs.io>`_.

Eskapade-Environment contains two configurations for run environments for Eskapade, currently docker and vagrant.


Release notes
=============

Version 0.9
-----------

In version 0.9 of Eskapade (December 2018) the docker and vagrant configurations have been taken out of the Eskapade repository,
and put into this separate package. This way, the Eskapade version no longer controls the version numbers of the published containers at dockerhub, 
which can now be set and updated stand-alone.

Also since version 0.9:

* The ``eskapade-usr`` docker is built on top of the `jupyter pyspark notebook <https://hub.docker.com/r/jupyter/pyspark-notebook/>`_,
which is well maintained, and no longer on KPMG's own ``KaveToolBox``.

* The ``eskapade-env`` (root-only) docker is no longer required and maintained. 


Installation
============

Eskapade requires Python 3 and is pip friendly. However Eskapade-ROOT and Eskapade-Spark require, you guessed it, ROOT and Spark,
which are available in the run environments.

* The Eskapade docker image contains the following versions: ``Eskapade v0.9.0``, ``Eskapade-ROOT v0.8.5``, and ``Eskapade-Spark v0.8.4``. Type:

  .. code-block:: bash

    $ docker pull kave/eskapade-usr:latest

  to pull it in.

  See the ``docker/`` directory for additional instructions.

* For vagrant, check the ``vagrant`` directory for detailed set-up instructions.


See `release notes <http://eskapade.readthedocs.io/en/latest/releasenotes.html>`_ for previous versions of Eskapade.


Contact and support
===================

Contact us at: kave [at] kpmg [dot] com

Please note that the KPMG Eskapade group provides support only on a best-effort basis.
