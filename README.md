4.3BSD retro-distribution
=========================

This repo intends to archive a working recreation/restoration of the
June 1986 4.3BSD distribution that is as historically accurate as possible.

Components of this distribution have been gathered from several primary sources around the internet.

Sources
-------

- Tape contents as .gz files from the wonderful people at
  The UNIX Heritage Society (TUHS):

    <https://www.tuhs.org/Archive/Distributions/UCB/4.3BSD/>

- Release instructions "Installing and Operating 4.3BSD on the VAX":

    <http://blog.livedoor.jp/suzanhud/archives/1585329.html> (japanese)

- The Awesome SIMH Simulator v4.0

    <https://github.com/simh/simh> (4.0 version)

    <http://simh.trailing-edge.com> (3.x classic version, valuable information)

- Simh related tools

    <https://github.com/simh/simtools>

Errata
------

1. The available PDF of "Installing and Operating 4.3BSD on the VAX" is missing
   some text, for example 0.1 "supported tape drives" and 0.4 "device naming".
   The 4.2BSD document is not missing this text so it is also included for
   reference.

   At a future time, it would be nice to recreate these PDFs from (nroff?)
   sources.

2. The TUHS sources do not contain the floppy or cassette images. The floppy
   will be recreated using the scripts/instructions on the tape `/usr/sys`.
