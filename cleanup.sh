#!/usr/bin/env bash

rm -rf ..Rcheck/\
    config.*\
    autom4te.cache\
    aclocal.m4\
    src/*.o\
    src/Makevars\
    src/libauto/*.o\
    src/libkcommon/*.o\
    src/libman/*.o\
    knor*.tar.gz\
    knor*.Rcheck\
    configure
