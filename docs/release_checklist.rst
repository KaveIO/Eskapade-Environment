===========================
Eskapade release check-list
===========================

* Released: Dec 10 2018

This document describes the steps to go through to release a new version of Eskapade.


Check list
==========

1. Test all relevant repositories
---------------------------------

Check for all relevant repositories that every test runs okay and all documents are generated okay.

.. note::
  At this stage do not yet tag the code.

* if failure:

  - fix and commit updates/fixes only in gitlab.
  - go to step 1.

* else: 

  - per repository: update version number in ``setup.py``, ``README.rst``, ``docs/source/conf.py``.
  - write release note in ``README.rst`` and ``releasenotes.rst``.
  - commit these updates only in gitlab.
  - go to step 2.

.. note::
  Be sure to write release notes in ``README.rst`` and ``releasenotes.rst``.
    

2. Push the code from gitlab to github
--------------------------------------

Here are the instructions for adding a remote git repository (for example ``Eskapade-Core`` on github) from an existing
repository (``Core`` on gitlab) and and pushing to it.

You should do this for each updated repository.

.. code-block:: bash
  $ cd top-of-eskapade-dir/
  $ # switch to master branch
  $ git checkout master
  $ # adding a remote repository called github             
  $ git remote add github git@github.com:KaveIO/Eskapade-Core.git
  $ # this next command shows the available remotes: origin and github
  $ git remote 
  $ # push to remote github
  $ git push github master

.. note::
  At this stage do not yet tag the code or push the tag to gitlab or github.

3. Update the read-the-docs pages
---------------------------------

The Eskapade documentation pages at read-the-docs are each built from the files in the github repositories,
and can now be updated.

.. note::
  Make sure the version numbers in ``setup.py``, ``README.rst``, ``docs/source/conf.py`` are up-to-date.

* Log in at `read-the-docs <https://readthedocs.org/>`_ with the kpmg user:

  - User name: *************
  - Password: *************

* Click on the ``kpmg_bigdata_nl`` box on the top-right of the page.
  This should bring you to an overview of project documentation registered at read-the-docs.

* Follow the instructions below for each project that needs to be updated.

* Click on a project that needs been updated.

* On the loaded page, click on ``Build version``. read-the-docs will install the latest version of the repository
  from github and then start building the documentation.

  If the code installation or documentation building fails for some reason on the read-the-docs server, there are two
  things you can control to make it work:

  - Edit the installation settings in the ``.readthedocs.yml`` file in the repository.
  - Make special exceptions for the read-the-docs server, for example in the ``setup.py`` file of the repository,
    or in the ``conf.py`` file in the ``docs/`` directory.

    .. code-block:: python
      # on_rtd is whether we are on readthedocs.org, this line of code grabbed from docs.readthedocs.org
      on_rtd = os.environ.get('READTHEDOCS', None) == 'True'

* if failure:

  - update the documentation and/or documentation's configuration (``conf.py``) and/or the ``setup.py`` file.
  - go back to step 1.

* else:

  - go to step 4.

4. Build the updated base docker image
--------------------------------------

Build locally the updated base docker (``eskapade-base``) and/or vagrant image(s) (for Eskapade), if needed, with updated version of various python packages, Spark, ROOT.
To do so, follow the instructions in the Environment package for `eskapade-base <https://github.com/KaveIO/Eskapade-Environment/tree/master/docker/eskapade-base>`_.

* Clone the Environment repository:
  .. code-block:: bash
    git clone https://git.kpmg.nl/KPMG-NL-AABD/Assets/Eskapade/Environment.git
    cd Environment/docker/eskapade-base/
    
* Update the ``Dockerfile``.
* Update and run the script ``create_docker.sh``.
  
.. note::
  This image is Eskapade package(s) independent, and is the basis of the Eskapade docker image.

.. note::
  Do not yet push this image to dockerhub.


5. Build the updated Eskapade docker image
------------------------------------------

Build locally the updated docker (``eskapade-usr``) and/or vagrant image(s) for Eskapade, with updated versions of the Eskapade packages.
To do so, follow the instructions in the Environment package for `eskapade-usr <https://github.com/KaveIO/Eskapade-Environment/tree/master/docker/eskapade-usr>`_.

* Go to the Environment repository:
  .. code-block:: bash
    cd Environment/docker/eskapade-usr/
    
* Update the ``Dockerfile`` with the new ``eskapade-base`` image.
* Update the ``Dockerfile`` with the latest Eskapade versions, but (for now) check them out from github (so, not yet from PyPi):

  .. code-block:: bash
    RUN source "${ROOT_ENV_SCRIPT}" \
    && pip install -e git+https://github.com/KaveIO/Eskapade-Core.git#egg=eskapade-core \
    && pip install -e git+https://github.com/KaveIO/Eskapade.git#egg=eskapade \
    && pip install -e git+https://github.com/KaveIO/Eskapade-ROOT.git#egg=eskapade-root \
    && pip install -e git+https://github.com/KaveIO/Eskapade-Spark.git#egg=eskapade-spark
                  
* Update and run the script ``create_docker.sh``.

* When done, start the image and run all the Eskapade tests to check if they run okay:

  .. code-block:: bash
    local$ docker run -it kave/eskapade-usr:latest bash
    docker$ eskapade_trail .

* if failure:

  - if code failure: fix and go to step 1.
  - else if docker failure: fix and goto step 4 or step 5.

* else: goto step 6.

.. note::
  Do not yet push this image to dockerhub.


6. Push the packages to PyPi
----------------------------

Time to push the updated package(s) to PyPi server. For each updated Eskapade package follow the instructions below.

.. note::
  Make sure the version numbers in ``setup.py``, ``README.rst``, ``docs/source/conf.py`` are up-to-date.

.. note::
  For detailed instructions on how to push packages to PyPi, see `PyPi here <Instructions at: https://packaging.python.org/tutorials/packaging-projects/>`_.


* Make sure you have installed the packages ``wheel`` and ``twine``:
  
  .. code-block:: bash
    pip install wheel
    pip install twine

* Build the wheel for each updated Eskapade package:

  .. code-block:: bash
    # build the wheel
    cd top-of-eskapade-dir/
    rm -Rf dist
    python setup.py bdist_wheel

* Upload the wheel to PyPi with the command:

  .. code-block:: bash
    # upload wheel to pypi
    twine upload dist/*
                  
* You will be asked for a username and password:
  - User name: *************
  - Password: *************

  After you provide these, the wheel of the package are uploaded to the PyPi server.


Congratulations, your updated package is now on PyPi.

But you're not done yet. Go to step 7.


7. git tag versions in gitlab and github
-------------------------------------------------------

Time to tag the code in gitlab and github.
You should do the following instructions for each updated repository.

.. note::
  Per repository, be sure to have updated the version number in ``setup.py``, ``README.rst``, ``docs/source/conf.py``.
  And be sure to write release notes in ``README.rst`` and ``releasenotes.rst``.

.. note::
  Below, replace 0.8 with your actual version number.

.. code-block:: bash
  # switch to master branch of repo
  cd top-of-eskapade-dir/
  git checkout master

  ## adding a remote repository called github             
  #git remote add github git@github.com:KaveIO/Eskapade-Core.git
  ## this next command shows the available remotes: origin and github
  #git remote 

  # tagging: replace 0.8 with your version number
  git tag -a v0.8 -m "Eskapade version 0.8"
  git push origin v0.8
  git push github v0.8


8. Update Eskapade docker image and push to dockerhub
-----------------------------------------------------

Like step 5, build locally the updated Eskapade docker (``eskapade-usr``) and/or vagrant image(s) for Eskapade, this time with the updated Eskapade packages from PyPi.
Again, we use the files from the Environment package for `eskapade-usr <https://github.com/KaveIO/Eskapade-Environment/tree/master/docker/eskapade-usr>`_.

.. note:: 
  To push docker images to dockerhub you need a docker account. If you do not have one, simply sign up at `dockerhub <https://hub.docker.com/>`_.
  Next, your user will also need to be part of the ``kave`` organization. Ask someone in the team with ``kave`` admin rights to add you.

* Go to the Environment repository:
  .. code-block:: bash
    cd Environment/docker/eskapade-usr/
  
* Update the ``Dockerfile`` with the latest Eskapade versions, but now check them out from PyPi.
  For example (fill in the correct version numbers):

  .. code-block:: bash
    RUN source "${ROOT_ENV_SCRIPT}" \
    && pip install Eskapade-Core==0.9.3 \
    && pip install Eskapade==0.9.3 \
    && pip install -e git+https://github.com/KaveIO/Eskapade-ROOT.git@v0.9.0#egg=eskapade-root \
    && pip install Eskapade-Spark==0.9.0

  Note that Eskapade-ROOT is installed from github, because somehow pip will not compile cxx files from PyPi, but will directly from github.
  Be sure to set the right tag of Eskapade-ROOT in this case.
    
* Run the script ``create_docker.sh``. 

* When done, start the image and run all the Eskapade tests. They should all run okay by now:

  .. code-block:: bash
    local$ docker run -it kave/eskapade-usr:latest bash
    docker$ eskapade_trail .

* Make sure to tag the ``latest`` docker images. For example (fill in the correct version numbers):
  .. code-block:: bash
    docker tag eskapade-base:YOUR_NEW_VERSION eskapade-base:latest
    docker tag eskapade-usr:YOUR_NEW_VERSION eskapade-usr:latest

* Push the docker images to dockerhub with (fill in the correct version numbers):
  .. code-block:: bash
    docker push eskapade-base:YOUR_NEW_VERSION
    docker push eskapade-base:latest
    docker push eskapade-usr:YOUR_NEW_VERSION
    docker push eskapade-usr:latest


9. Commit and tag the updates to the Environment package
--------------------------------------------------------

Commit and tag the updates to the Environment package. Below, make sure to tag the correct version number.

.. note::
  The tag of the Environment package typically follows the tag of the latest ``eskapade-usr`` docker image.

.. note::
  Be sure to write release notes of the latest images in ``README.rst``.

After committing the code, make sure to tag and also push the changes to github:
  
.. code-block:: bash
  # switch to master branch of environment repo
  cd Environment/
  git checkout master

  # adding the remote Environment repository, called github             
  git remote add github git@github.com:KaveIO/Eskapade-Environment.git
  # this next command shows the available remotes: origin and github
  git remote 

  # push the changes to origin
  git push
  # push to remote
  git push github master
  
  # tagging: replace 0.8 with your version new number
  git tag -a v0.8 -m "Eskapade docker version 0.8"
  git push origin v0.8
  git push github v0.8

  
10. Update the read-the-docs pages with the final github repositories
---------------------------------------------------------------------

Last step is to update the read-the-docs pages with final github repositories.
See the instructions at step 3.



Contact and support
===================

Contact us at: kave [at] kpmg [dot] com

Please note that the KPMG Eskapade group provides support only on a best-effort basis.
