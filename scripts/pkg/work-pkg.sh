# Install CAC cert packages on linux
# URL https://militarycac.com/linux.htm
# https://help.ubuntu.com/community/CommonAccessCard
CAC_PKG=(libpcsclite1 pcscd pcsc-tools cackey coolkey libckyapplet1)

for i in in "${CAC_PKG[@]}";
do
    $INSTALL $i
    sudo systemctl enable pcscd
    sudo systemctl restart pcscd
done


# cackey - CAC and PIV Smartcard PKCS #11 cryptographic module
# coolkey - Smart Card PKCS #11 cryptographic module
# libckyapplet1 - Smart Card Coolkey applet
# libckyapplet1-dev - Smart Card Coolkey applet development files

# Software packages
#
# In order to use the DoD CAC you must install the following packages:
#
#  pcsc-lite - PCSC Smart Cards Library
#
#  pcsc-ccid - generic USB CCID (Chip/Smart Card Interface Devices) driver
#
#  perl-pcsc - Abstraction layer to smart card readers
#
#  pcsc-tools - Optional but highly recommended, these tools are used to test a PCSC driver, card and reader
#
# Note:  Be sure to select the package that corresponds with your distribution version
#
# The naming of this package / library name varies from one distribution to another depending on the package maintainer.  For example if you want to find the pcsc-lite package, enter into the search engine of your choice:
#
#  pcsc lite yourdisribution
#
# Replace yourdisribution with openSUSE, Fedora or Ubuntu; whatever you are running
