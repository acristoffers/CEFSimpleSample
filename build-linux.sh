#!/usr/bin/env bash

mkdir -p bin # for silencing the next line, in case the folder does not exist
rm -r bin
mkdir -p build
touch build/touched # for silencing the next line, in case the folder was just created
rm -r build/*
cd build

echo "Building CEFSimpleSample::Independent"
g++ -c ../CEFSimpleSample/Independent/*.cpp \
	-I ../CEFSimpleSample/Independent \
	-I ../CEFSimpleSample/CEF/Linux \
	-I ../CEFSimpleSample/CEF/Linux/include \
	`pkg-config --cflags --libs gtk+-2.0`

echo "Building CEFSimpleSample::Linux"
g++ -c ../CEFSimpleSample/Linux/*.cpp \
	-I ../CEFSimpleSample/Independent \
	-I ../CEFSimpleSample/CEF/Linux \
	-I ../CEFSimpleSample/CEF/Linux/include \
	`pkg-config --cflags --libs gtk+-2.0`

echo "Linking..."
g++ *.o \
	../CEFSimpleSample/CEF/Linux/lib/libcef_dll_wrapper.a \
	-o CEFSimpleSample \
	`pkg-config --cflags --libs gtk+-2.0` \
	-L ../CEFSimpleSample/CEF/Linux/lib \
	-ldl \
	-lcef \
	-Wl,-R. -Wl,-R/usr/lib

echo "Copying files around..."
rm *.o
mkdir bin
mv CEFSimpleSample bin/
cp -r ../CEFSimpleSample/CEF/Linux/resources/* bin/
cp -r ../CEFSimpleSample/CEF/Linux/lib/*.so bin/
cp -r ../CEFSimpleSample/Independent/html bin/
mv bin ..
cd ..
rm -r build

