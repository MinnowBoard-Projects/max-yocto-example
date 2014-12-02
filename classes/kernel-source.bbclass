#
# This function is taken from classes/kernel.bbclass found in the Yocto Project's poky repository.
# It was modified on December 1, 2014 by California Sullivan.
#

FULL_KERNEL_SRC_DIR="/usr/src/kernel-full"

do_install_prepend() {
        #
        # Copy the entire source tree. In case an external build directory is
        # used, copy the build directory over first, then copy over the source
        # dir. This ensures the original Makefiles are used and not the
        # redirecting Makefiles in the build directory.
        #
        install -d ${D}${FULL_KERNEL_SRC_DIR}/
        find . -depth -not -name "*.cmd" -not -name "*.o" -not -name "*.so.dbg" -not -name "*.so" -not -path "./Documentation*" -not -path "./source*" -not -path "./.*" -print0 | cpio --null -pdlu ${D}${FULL_KERNEL_SRC_DIR}/
        cp .config ${D}${FULL_KERNEL_SRC_DIR}/
        if [ "${S}" != "${B}" ]; then
                pwd="$PWD"
                cd "${S}"
                find . -depth -not -path "./Documentation*" -not -path "./.*" -print0 | cpio --null -pdlu ${D}${FULL_KERNEL_SRC_DIR}
                cd "$pwd"
        fi

        # Test to ensure that the output file and image type are not actually
        # the same file. If hardlinking is used, they will be the same, and there's
        # no need to install.
        ! [ ${KERNEL_OUTPUT} -ef ${D}${FULL_KERNEL_SRC_DIR}/${KERNEL_IMAGETYPE} ] && install -m 0644 ${KERNEL_OUTPUT} ${D}${FULL_KERNEL_SRC_DIR}/${KERNEL_IMAGETYPE}
        install -m 0644 System.map ${D}${FULL_KERNEL_SRC_DIR}/System.map-${KERNEL_VERSION}

        # Dummy Makefile so the clean below works
        mkdir ${D}${FULL_KERNEL_SRC_DIR}/Documentation
        touch ${D}${FULL_KERNEL_SRC_DIR}/Documentation/Makefile

        #
        # Clean and remove files not needed for building modules.
        # Some distributions go through a lot more trouble to strip out
        # unecessary headers, for now, we just prune the obvious bits.
        #
        # We don't want to leave host-arch binaries in /sysroots, so
        # we clean the scripts dir while leaving the generated config
        # and include files.
        #
        oe_runmake -C ${D}${FULL_KERNEL_SRC_DIR}/ CC="${KERNEL_CC}" LD="${KERNEL_LD}" clean _mrproper_scripts
}

PACKAGES =+ "kernel-source"
FILES_kernel-source = "${FULL_KERNEL_SRC_DIR}"
