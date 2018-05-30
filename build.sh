#!/bin/bash
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in &&
sed -i -e "/SUBDIRS/s|man[25]||g" man/Makefile &&
sed -i 's:{(:\\{(:' test/run &&
./configure --prefix=/usr \
            --disable-static &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install install-dev install-lib &&
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libattr.so" &&
mkdir -v "${SHED_FAKE_ROOT}/lib" &&
mv -v "${SHED_FAKE_ROOT}"/usr/lib/libattr.so.* "${SHED_FAKE_ROOT}/lib" &&
ln -sfv ../../lib/$(readlink "${SHED_FAKE_ROOT}/usr/lib/libattr.so") "${SHED_FAKE_ROOT}/usr/lib/libattr.so"
