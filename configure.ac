AC_INIT(knorR, @VERSION@, disa@jhu.edu)
AC_CONFIG_SRCDIR(src/rinterface.cpp)
AC_CONFIG_HEADERS(src/config.h)
AC_CONFIG_MACRO_DIR([/usr/share/aclocal/])

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
   echo "could not determine R_HOME"
   exit 1
fi
CC=`"${R_HOME}/bin/R" CMD config CC`
CXX=`"${R_HOME}/bin/R" CMD config CXX`
FC=`"${R_HOME}/bin/R" CMD config FC`
CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
CXXFLAGS=`"${R_HOME}/bin/R" CMD config CXXFLAGS`
CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
FCFLAGS=`"${R_HOME}/bin/R" CMD config FCFLAGS`
FLIBS=`"${R_HOME}/bin/R" CMD config FLIBS`

AC_LANG(C)
AC_PROG_CC

AC_LANG(C++)
AC_REQUIRE_CPP

#AX_CXX_COMPILE_STDCXX_11

LIBS_SAVE=$LIBS
LIBS="$LIBS -lm"
LIBS=$LIBS_SAVE

AC_CHECK_HEADER([sys/times.h],
      [AC_DEFINE([HAVE_TIMES_H], [1], [Define to 1 if you have the sys/times.h header])])

AC_CHECK_HEADER([boost/assert.hpp], [], [AC_MSG_ERROR("can't find boost assert")])
AC_CHECK_HEADER([boost/log/trivial.hpp], [], [AC_MSG_ERROR("can't find boost trivial")])
AC_CHECK_HEADER([boost/log/expressions.hpp], [], [AC_MSG_ERROR("can't find boost log expressions")])

AC_CHECK_HEADER([hwloc.h], [AC_SUBST(HWLOC_DEF, -DUSE_HWLOC)])
AC_CHECK_LIB([hwloc], [hwloc_topology_load], [AC_SUBST(HWLOC_LIB, -lhwloc)])

AC_CHECK_HEADER([pthread.h], [], [AC_MSG_ERROR("can't find pthread")])
AC_CHECK_LIB([pthread], [pthread_create], [AC_SUBST(PTHREAD_LIB, -lpthread)], [AC_MSG_ERROR("can't find pthread")])

AC_CHECK_HEADER([numa.h], [AC_SUBST(NUMA_DEF, -DUSE_NUMA)])
AC_CHECK_LIB([numa], [numa_alloc_local], [AC_SUBST(NUMA_LIB, -lnuma)])

echo "search for FlashR"
libpaths=`R -e 'cat(.libPaths(), "\n")' --no-save --slave`
FlashR_lib=""
for x in $libpaths
do
	AS_IF([test -f "$x/knorR/libs/knorR.so"], [AC_SUBST(FlashR_lib, "$x/knorR/libs/knorR.so")], [])
done
AS_IF([test "$knorR_lib" = "" ], [AC_MSG_ERROR("cannot find knorR")], [])

AC_CONFIG_FILES([src/Makevars.tmp:src/Makevars.in], [
    if test -f src/Makevars && cmp -s src/Makevars.tmp src/Makevars; then
      AC_MSG_NOTICE([creating src/Makevars])
      AC_MSG_NOTICE([src/Makevars is unchanged])
      rm src/Makevars.tmp
    else
      AC_MSG_NOTICE([creating src/Makevars])
      mv src/Makevars.tmp src/Makevars
    fi
  ]
)

AC_OUTPUT