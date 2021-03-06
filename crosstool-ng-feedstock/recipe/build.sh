#!/bin/bash

export EXTRA_CFLAGS="-I${PREFIX}/include -I${PREFIX}/include/ncurses"
export EXTRA_LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib -lncursesw"
# -rpath-link is needed because libncursesw.so dependes on libtinfo.so and
# configure will fail to find ncurses without it (if using the conda ncurses
# package).
export CPPFLAGS="-I${PREFIX}/include -L${PREFIX}/lib -Wl,-rpath-link,${PREFIX}/lib"
if [[ $(uname) == Darwin ]]; then
  export DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib
fi
./bootstrap
./configure --prefix=${PREFIX}
make -j${CPU_COUNT} ${VERBOSE_AT}
make install
