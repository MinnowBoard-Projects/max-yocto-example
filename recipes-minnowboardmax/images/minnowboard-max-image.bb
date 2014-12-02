DESCRIPTION = "SDK Image for the MinnowBoard Max"
LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "tools-sdk \
                   dev-pkgs \
                  "

IMAGE_INSTALL_append = "bc \
                        kernel-dev \
                        minnow-max-extras \
                        kernel-source \
                       "
