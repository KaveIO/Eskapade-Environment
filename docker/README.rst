Eskapade with Docker
====================

Consistent environments for Eskapade development and use can be created with docker containers. Containers are created and managed by `Docker <https://www.docker.com/>`_. An Eskapade container contains a pre-installed Eskapade setup and runs out-of-the-box.  It is possible to mount your customised Eskapade code for development inside the container.

The instructions below show how one can use a locally checked-out version of Eskapade in combination with this Docker image. This combination is a very convenient way of actively working with and/or developing code in Eskapade.

By default, Eskapade code is executed as ``root`` user in the container. It is possible, however, to run with reduced user privileges inside containers through user
mapping with the Docker host, as decribed in the last section.


Required software
_________________

Docker installation instructions can be found here: `<https://docs.docker.com/install/>`_.

The Eskapade Dockerfile is optional (for development purposes), you can check it out locally with the command:

.. code-block:: bash

  git clone https://github.com:KaveIO/Eskapade-Environment.git environment



Getting Eskapade docker images
______________________________

From DockerHub
::::::::::::::

The official Eskapade docker image is provided on `DockerHub <https://hub.docker.com/r/kave/eskapade-usr/>`_.

.. code:: bash

  $  docker pull kave/eskapade-usr:latest

This will download the ``kave/eskapade-usr:latest`` image locally.
Downloading this docker image can take a minute or two.



Building from scratch
:::::::::::::::::::::

To build the docker image from scratch, do:

.. code:: bash

  $  cd environment/docker/eskapade-usr && sh create_docker.sh

This will produce the ``kave/eskapade-usr:latest`` image locally.


Spinning up docker containers
_____________________________

Out-of-the-box
::::::::::::::

From this image, containers with the Eskapade environment set up, can be run out-of-the-box:

.. code:: bash

  $  docker run -p 8888:8888 -it kave/eskapade-usr:latest bash

Where port 8888 is forwarded to the docker host to make Jupyter notebook available (below).

E.g. one can now do:

.. code-block:: bash

  eskapade_run --help

and run any Eskapade code. See the `Tutorials section <https://eskapade.readthedocs.io/en/latest/tutorials.html>`_ for examples.

Exit the (docker) bash shell with:

.. code-block:: bash

  exit

See section `After you exit Docker`_ (below) for cleaning up obsolete docker processes.


Mounting source code
::::::::::::::::::::

In this example we create a directory ``work``.
We give the default docker user (jovyan) user ownership (uid=1000), 
and start the container with the host work folder mounted.

.. code:: bash

  $  mkdir work
  $  sudo chown 1000 work
  $  docker run -v $PWD/work:/opt/work -p 8888:8888 -it kave/eskapade-usr:latest bash

Where ``$PWD/work`` specifies the path of the code on the local machine, and where ``/opt/work`` is the location of the Eskapade source code inside the container.


Running as root user
::::::::::::::::::::

.. code:: bash

  $  docker run -p 8888:8888 -u root -it kave/eskapade-usr:latest bash




Starting Jupyter notebook
_________________________

To run the Jupyter notebook on port 8888 from the docker environment:

.. code-block:: bash

  jupy &

And press enter twice to return to the shell prompt.

The command ``jupy &`` starts up Jupyter notebook in the background on port 8888.

In your local browser then go to address::

  localhost:8888/

And you will see the familiar Jupyter environment.

E.g. you can now do ``import eskapade`` (shift-enter) to get access to the Eskapade library.

Be sure to run ``jupy &`` from a directory that is mounted in the docker container.
In this way any notebook(s) you create are kept after you exit the docker run.


After you exit Docker
_____________________

Every time you want to have a clean Docker environment, run the following commands:

.. code-block:: bash

  # --- 1. remove all exited docker processes
  docker ps -a | grep Exited | awk '{print "docker stop "$1 "; docker rm "$1}' | sh

  # --- 2. remove all failed docker image builts
  docker images | grep "<none>" | awk '{print "docker rmi "$3}' | sh

  # --- 3. remove dangling volume mounts
  docker volume ls -qf dangling=true | awk '{print "docker volume rm "$1}' | sh

To automate this, we advise you put these commands in an executable ``docker_cleanup.sh`` script.
