This is a fork of [SuiteSparse](https://github.com/DrTimothyAldenDavis/SuiteSparse) that just builds UMFPACK v5.0.2. This was the last UMFPACK to be released under the LGPL. SuiteSparse did not use cmake at the time, so a cmake build script has been added. The build requires source files to be compiled multiple times. This is accomplished in cmake by creating object library targets for each set compiler definitions. To aid in creating a cmake script for this, a python script was used to parse the UMFPACK make file and generate the appropriate object targets.

Some headers have been modified to make the build easier. Namely the loop vectorization pragmas have been replaced by a macro, which is configured by the compiler. Another compiler definition was added to allow linking to OpenBLAS in windows, which puts trailing "_" after all the fortran function names. You can point to the OpenBLAS location using the CMAKE_PREFIX_PATH variable. To build the AMD and UMFPACK demos, use the BUILD_DEMOS option. To build a shared library, use the BUILD_SHARED_LIBS option. Building with the Visual Studio generator, or any toolchain that uses Visual Studio linker will only build the UMFPACK dll, the AMD library will be a static library. The AMD library uses a few function pointers that are globals and not handled by the automatic DLL export feature of cmake and would require extra code to get the export/import working properly.

Example compile steps for windows:
From the base directory after running vcvars64.bat:
```
mkdir build
cd build
cmake .. -DBUILD_SHARED_LIBS=ON -DBUILD_DEMOS=ON -DCMAKE_PREFIX_PATH=<path to OpenBLAS> -G "Visual Studio 17 2022" -T host=x64 -A x64
```

Build with:
```
cmake --build . --config Release -j <num jobs>
```

Install with:
```
cmake --install . --config Release --prefix <path to install>
```

For single configuration builds, use -DCMAKE_BUILD_TYPE=Release in the configuration step and omit the --config options from the build and install commands. Replace Release with Debug in the above for a debug build.

See [AMD/Doc/License](AMD/doc/License) and [UMFPACK/Doc/License](UMFPACK/Doc/License) for licensing details.