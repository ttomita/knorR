AC_INIT(knor, @VERSION@, disa@jhu.edu)
AC_CONFIG_SRCDIR(src/rinterface.cpp)
AC_CONFIG_HEADERS(src/config.h)
AC_CONFIG_MACRO_DIR([/usr/share/aclocal])

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
   echo "could not determine R_HOME"
   exit 1
fi
CC=`"${R_HOME}/bin/R" CMD config CC`
CXX=`"${R_HOME}/bin/R" CMD config CXX`
FC=`"${R_HOME}/bin/R" CMD config FC`
CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`

AC_LANG(C)
AC_PROG_CC

AC_LANG(C++)
AC_REQUIRE_CPP

LIBS_SAVE=$LIBS
LIBS="$LIBS -lm"
LIBS=$LIBS_SAVE

AC_CHECK_HEADER([sys/times.h],
      [AC_DEFINE([HAVE_TIMES_H], [1], [Define to 1 if you have the sys/times.h header])])

AC_CHECK_HEADER([pthread.h], [], [AC_MSG_ERROR("can't find pthread")])
AC_CHECK_LIB([pthread], [pthread_create], [AC_SUBST(PTHREAD_LIB, -lpthread)], [AC_MSG_ERROR("can't find pthread")])

AC_CHECK_HEADER([numa.h], [AC_SUBST(NUMA_DEF, -DUSE_NUMA)])
AC_CHECK_LIB([numa], [numa_alloc_local], [AC_SUBST(NUMA_LIB, -lnuma)])

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
