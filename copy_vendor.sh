
#
# Before running this script please extract raw vendor image
# and mount loop image to some mount point. Give that mount point
# parameter for this script.
#
# 1. "simg2img vendor.img vendor.raw" (Run inside Mer SDK target)
# 2. "mkdir ~/vendor"
# 3. "sudo mount -t ext4 -o loop vendor.raw ~/vendor"
# 4. "./copy_vendor.sh ~/vendor"
#

if [ -z "$1" ]; then
  echo "No argument supplied, try $0 ~/path/to/vendor"
  exit
fi

VENDOR_SPARSE="sparse/vendor"
VENDOR_MOUNT=$1

# Add read permission for some binaries under vendor mount
source helpers/fixup-permissions.sh

# Remove current sparse and create it again
rm -rf $VENDOR_SPARSE
mkdir -p $VENDOR_SPARSE

# Copy content
echo "Copy $VENDOR_MOUNT/* to $VENDOR_SPARSE"
cp -r $VENDOR_MOUNT/* $VENDOR_SPARSE

# Remove generic unused directories and files
source helpers/remove-unused.sh

