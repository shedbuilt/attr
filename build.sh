#!/bin/bash
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i -e "/SUBDIRS/s|man[25]||g" man/Makefile
sed -i 's:{(:\\{(:' test/run
./configure --prefix=/usr \
            --disable-static
make -j $SHED_NUMJOBS
make DESTDIR=$SHED_FAKEROOT install install-dev install-lib
chmod -v 755 ${SHED_FAKEROOT}/usr/lib/libattr.so
mkdir -v ${SHED_FAKEROOT}/lib
mv -v ${SHED_FAKEROOT}/usr/lib/libattr.so.* ${SHED_FAKEROOT}/lib
ln -sfv ../../lib/$(readlink ${SHED_FAKEROOT}/usr/lib/libattr.so) ${SHED_FAKEROOT}/usr/lib/libattr.so
