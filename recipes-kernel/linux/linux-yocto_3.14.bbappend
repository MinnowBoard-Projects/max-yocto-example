inherit kernel-source

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://enable-spi.cfg"
