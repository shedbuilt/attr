#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
./configure --prefix=/usr \
            --sysconfdir=/etc \
            --docdir="$SHED_PKG_DOCS_INSTALL_DIR" \
            --disable-static &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
# Rearrange
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libattr.so" &&
mkdir -v "${SHED_FAKE_ROOT}/lib" &&
mv -v "${SHED_FAKE_ROOT}"/usr/lib/libattr.so.* "${SHED_FAKE_ROOT}/lib" &&
ln -sfv ../../lib/$(readlink "${SHED_FAKE_ROOT}/usr/lib/libattr.so") "${SHED_FAKE_ROOT}/usr/lib/libattr.so" || exit 1
# Prune Documentation
if [ -z "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    rm -rf "${SHED_FAKE_ROOT}/usr/share/doc"
fi
