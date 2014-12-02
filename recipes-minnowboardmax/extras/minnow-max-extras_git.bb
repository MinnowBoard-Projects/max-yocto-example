DESCRIPTION = "Extra files for the MinnowBoard Max"
HOMEPAGE = "https://github.com/MinnowBoard/minnow-max-extras"
SECTION = "other"
LICENSE = "GPLv2"

SRC_URI = "git://github.com/MinnowBoard/minnow-max-extras.git;protocol=https"
SRCREV = "b081c789eafc2597e5faac12aa318c6a0f582d05"

LIC_FILES_CHKSUM = "file://README;md5=fcc5789f17ab3f7a6eec3298dc033a66"

S = "${WORKDIR}/git"

do_configure() {
}

do_install() {
	install -d ${D}${datadir}/minnow-max-extras
	cp -r * ${D}${datadir}/minnow-max-extras/
}

FILES_${PN} += " \
	${datadir}/minnow-max-extras \
"

