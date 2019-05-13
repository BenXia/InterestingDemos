#!/bin/sh

set -xe

VERSION="0.1.3"                                                           #
#SDKVERSION="6.1"
SDKVERSION="8.4"
LIBSRCNAME="opencore-amr"

CURRENTPATH=`pwd`

mkdir -p "${CURRENTPATH}/src"
tar zxf opencore-amr-${VERSION}.tar.gz -C "${CURRENTPATH}/src"
cd "${CURRENTPATH}/src/opencore-amr-${VERSION}"

DEVELOPER=`xcode-select -print-path`
DEST="${CURRENTPATH}/opencore-amr-iphone"
mkdir -p "${DEST}"

ARCHS="i386 armv7 armv7s arm64 x86_64"  #armv7 armv7s
LIBS="libopencore-amrnb.a libopencore-amrwb.a"

for arch in $ARCHS; do
case $arch in
arm*)

echo "Building opencore-amr for iPhone $arch ****************"
if [ $arch == "arm64" ]
then
IOSV="-miphoneos-version-min=7.0"
fi

SDKROOT="$(xcrun --sdk iphoneos --show-sdk-path)"
CC="$(xcrun --sdk iphoneos -f clang)"
CXX="$(xcrun --sdk iphoneos -f clang++)"
CPP="$(xcrun -sdk iphonesimulator -f clang++)"
CFLAGS="-isysroot $SDKROOT -arch $arch $IOSV -isystem $SDKROOT/usr/include -fembed-bitcode"
CXXFLAGS=$CFLAGS
CPPFLAGS=$CFLAGS
export CC CXX CFLAGS CXXFLAGS CPPFLAGS
./configure \
--host=arm-apple-darwin \
--prefix=$DEST \
--disable-shared --enable-static
;;

#PLATFORM="iPhoneOS"
#PATH="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer/usr/bin:$PATH"
#SDK="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer/SDKs/${PLATFORM}${SDKVERSION}.sdk"
#CC="gcc -arch $arch --sysroot=$SDK" CXX="g++ -arch $arch --sysroot=$SDK" \
#LDFLAGS="-Wl,-syslibroot,$SDK" ./configure \
#--host=arm-apple-darwin \
#--prefix=$DEST \
#--disable-shared #--enable-gcc-armv7
#;;
i386)
echo "Building opencore-amr for iPhoneSimulator $arch*****************"
IOSV="-mios-simulator-version-min=7.0"
#PLATFORM="iPhoneSimulator"
SDKROOT=`xcodebuild -version -sdk iphonesimulator Path`
CC="$(xcrun -sdk iphoneos -f clang)"
CXX="$(xcrun -sdk iphonesimulator -f clang++)"
CPP="$(xcrun -sdk iphonesimulator -f clang++)"
CFLAGS="-isysroot $SDKROOT -arch $arch $IOSV -isystem $SDKROOT/usr/include -fembed-bitcode"
CXXFLAGS=$CFLAGS
CPPFLAGS=$CFLAGS
export CC CXX CFLAGS CXXFLAGS CPPFLAGS
#PATH="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer/usr/bin:$PATH"
#SDK="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer/SDKs/${PLATFORM}${SDKVERSION}.sdk"
#CC="gcc -arch $arch" CXX="g++ -arch $arch" \
./configure \
--host=i386 \
--prefix=$DEST \
--disable-shared
;;
x86_64)
echo "Building opencore-amr for iPhoneSimulator $arch*****************"
IOSV="-mios-simulator-version-min=7.0"
#PLATFORM="iPhoneSimulator"
SDKROOT=`xcodebuild -version -sdk iphonesimulator Path`
CC="$(xcrun -sdk iphoneos -f clang)"
CXX="$(xcrun -sdk iphonesimulator -f clang++)"
CPP="$(xcrun -sdk iphonesimulator -f clang++)"
CFLAGS="-isysroot $SDKROOT -arch $arch $IOSV -isystem $SDKROOT/usr/include -fembed-bitcode"
CXXFLAGS=$CFLAGS
CPPFLAGS=$CFLAGS
export CC CXX CFLAGS CXXFLAGS CPPFLAGS
#PATH="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer/usr/bin:$PATH"
#SDK="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer/SDKs/${PLATFORM}${SDKVERSION}.sdk"
#CC="gcc -arch $arch" CXX="g++ -arch $arch" \
./configure \
--host=x86_64 \
--prefix=$DEST \
--disable-shared
;;
esac
make -j3 > /dev/null
make install
make clean
for i in $LIBS; do
mv $DEST/lib/$i $DEST/lib/$i.$arch
done
done

for i in $LIBS; do
input=""
for arch in $ARCHS; do
input="$input $DEST/lib/$i.$arch"
done
lipo -create -output $DEST/lib/$i $input
done
