#!/usr/bin/env python3
import re
import os
import os.path
import textwrap

# parse the makefile and then write a number of rules that correspond to combinations of 
# compiler definitions.

prefix = "umf"
libName = "umfpack"
cmakeName = "umfpack.cmake"

# verify this is run from the UMFPACK directory
with open("README.txt", "r") as fp:
    line = fp.readline()
    res = re.search("UMFPACK Version", line)
    if not res:
        raise RuntimeError("Launched in incorrect directory.")

# function that parses the make fil and outputs the list of objects and a dictionary of source
# dependencies indexed by a tuple of compile definitions.
def parse_makefile():
    with open(os.path.join("Lib", "GNUmakefile"), "r") as fp:
        makefileContents = fp.read()

    # get list UMFCH
    res = re.search(r"UMFCH = (.*?[^\\])\n", makefileContents, re.DOTALL)
    UMFCH = re.sub(r"[\\\n\t]", "", res.group(1)).split(" ")
    
    # get list UMFINT
    res = re.search(r"UMFINT = (.*?[^\\])\n", makefileContents, re.DOTALL)
    UMFINT = re.sub(r"[\\\n\t]", "", res.group(1)).split(" ")

    # get list UMF_CREATED
    res = re.search(r"UMF_CREATED = (.*?[^\\])\n", makefileContents, re.DOTALL)
    UMF_CREATED = re.sub(r"[\\\n\t]", "", res.group(1)).split(" ")

    # get list UMFPACK
    res = re.search(r"UMFPACK = (.*?[^\\])\n", makefileContents, re.DOTALL)
    UMFPACK = re.sub(r"[\\\n\t]", "", res.group(1)).split(" ")

    # get list UMFPACKW
    res = re.search(r"UMFPACKW = (.*?[^\\])\n", makefileContents, re.DOTALL)
    UMFPACKW = re.sub(r"[\\\n\t]", "", res.group(1)).split(" ")

    # get list GENERIC
    res = re.search(r"GENERIC = (.*?[^\\])\n", makefileContents, re.DOTALL)
    GENERIC = re.sub(r"[\\\n\t]", "", res.group(1)).split(" ")

    UMF = UMF_CREATED + UMFCH
    USER = UMFPACKW + UMFPACK

    # build lists of object files
    DI = ["{}.o".format(re.sub("umf_", "umf_di_", s)) for s in UMF] + ["{}.o".format(re.sub("umfpack_", "umfpack_di_", s)) for s in USER]
    DL = ["{}.o".format(re.sub("umf_", "umf_dl_", s)) for s in UMF] + ["{}.o".format(re.sub("umfpack_", "umfpack_dl_", s)) for s in USER]
    ZI = ["{}.o".format(re.sub("umf_", "umf_zi_", s)) for s in UMF] + ["{}.o".format(re.sub("umfpack_", "umfpack_zi_", s)) for s in USER]
    ZL = ["{}.o".format(re.sub("umf_", "umf_zl_", s)) for s in UMF] + ["{}.o".format(re.sub("umfpack_", "umfpack_zl_", s)) for s in USER]
    II = ["{}.o".format(re.sub("umf_", "umf_i_", s)) for s in UMFINT]
    LL = ["{}.o".format(re.sub("umf_", "umf_l_", s)) for s in UMFINT]
    GN = ["{}.o".format(re.sub("umfpack_", "umfpack_gn_", s)) for s in GENERIC]

    # build object list
    objs = []

    # int and long routines
    objs += [["{}.o".format(re.sub("umf_", "umf_i_", s)), "{}.c".format(s), ["DINT"]] for s in UMFINT]
    objs += [["{}.o".format(re.sub("umf_", "umf_l_", s)), "{}.c".format(s), ["DLONG"]] for s in UMFINT]
    objs += [["{}.o".format(re.sub("umfpack_", "umfpack_gn_", s)), "{}.c".format(s), ["_NONE_"]] for s in GENERIC]

    # build other routines
    for (dType, dDef) in [("di", "DINT"), ("dl", "DLONG"), ("zi", "ZINT"), ("zl", "ZLONG")]:
        tmp = [["{}.o".format(re.sub("umf_", f"umf_{dType}_", s)), f"{s}.c", [dDef]] for s in UMF] \
            + [["{}.o".format(re.sub("umfpack_", f"umfpack_{dType}_", s)), f"{s}.c", [dDef]] for s in USER]

        # find specific substitutions 
        for item in tmp:
            res = re.match(f"umf_{dType}_(.)hsolve\\.o", item[0])
            if res:
                item[1] = f"umf_{res.group(1)}tsolve.c"
                item[2] = [dDef, "CONJUGATE_SOLVE"]
                continue

            res = re.match(f"umf_{dType}_triplet_map_x\\.o", item[0])
            if res:
                item[1] = "umf_triplet.c"
                item[2] = [dDef, "DO_MAP", "DO_VALUES"]
                continue

            res = re.match(f"umf_{dType}_triplet_map_nox\\.o", item[0])
            if res:
                item[1] = "umf_triplet.c"
                item[2] = [dDef, "DO_MAP"]
                continue

            res = re.match(f"umf_{dType}_triplet_nomap_x\\.o", item[0])
            if res:
                item[1] = "umf_triplet.c"
                item[2] = [dDef, "DO_VALUES"]
                continue

            res = re.match(f"umf_{dType}_triplet_nomap_nox\\.o", item[0])
            if res:
                item[1] = "umf_triplet.c"
                item[2] = [dDef]
                continue

            res = re.match(f"umf_{dType}_assemble_fixq\\.o", item[0])
            if res:
                item[1] = "umf_assemble.c"
                item[2] = [dDef, "FIXQ"]
                continue

            res = re.match(f"umf_{dType}_store_lu_drop\\.o", item[0])
            if res:
                item[1] = "umf_store_lu.c"
                item[2] = [dDef, "DROP"]
                continue
            
            res = re.match(f"umfpack_{dType}_wsolve\\.o", item[0])
            if res:
                item[1] = "umfpack_solve.c"
                item[2] = [dDef, "WSOLVE"]
                continue

        # store the dType object data
        objs += tmp
            

    # verify build list matches object list
    assert(len(DI) + len(DL) + len(ZI) + len(ZL) + len(II) + len(LL) + len(GN) == len(objs))

    # build an object dictionary
    objDict = {}

    for obj in objs:
        # create a key of the definitions
        key = tuple(obj[2])
        
        # add an empty list
        if not key in objDict.keys():
            objDict[key] = []
        
        # append the dependent source
        objDict[key].append(obj[1])

    return objs, objDict

# get the compiler output objects, their definitions, and dependencies
objs, objDict = parse_makefile()

    
# write a bunch of object targets
with open(os.path.join("cmake", cmakeName), "w") as fp:
    # write a header variable
    print("# get all headers", file=fp)
    print(f"file(GLOB {prefix}_public_headers \"${{CMAKE_CURRENT_SOURCE_DIR}}/Include/*.h\")", file=fp)
    print("", file=fp)

    tgtList = []

    for key in objDict.keys():
        if key == "_NONE_":
            tgtName = f"{prefix}_none_objs"
        else:
            defnames = "_".join(key)
            tgtName = f"{prefix}_{defnames}_objs"
        
        # add the target to a list
        tgtList.append(tgtName)

        # write a target object library
        print(f"add_library({tgtName} OBJECT", file=fp)
        for src in objDict[key]:
            print(f"    ${{CMAKE_CURRENT_SOURCE_DIR}}/Source/{src}", file=fp)
        print(")\n", file=fp)

        # add a compile definitions
        print(f"target_compile_definitions({tgtName} PUBLIC BLAS_UNDERSCORE)", file=fp)
        print(f"if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))", file=fp)
        print(f"    target_compile_definitions({tgtName} PRIVATE", file=fp)
        print("        ${UMFPACK_DEFINE_IVDEP}", file=fp)
        print("        ${UMFPACK_DEFINE_NOVECTOR}", file=fp)
        print("    )", file=fp)
        print("endif()\n", file=fp)

        if key != "_NONE_":
            print(f"target_compile_definitions({tgtName} PRIVATE", file=fp)
            for k in key:
                print(f"    {k}", file=fp)
            print(")\n", file=fp)
        
        # add compile options
        print(textwrap.dedent(f"""\
            target_compile_options({tgtName} PRIVATE 
                $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
                $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
            )\n"""), file=fp)
        
        # add target link libraries for amd
        print(f"target_link_libraries({tgtName} PRIVATE amd)\n", file=fp)

        # add target include directory
        print(f"target_include_directories({tgtName} PRIVATE ${{config_dir}} ${{CMAKE_CURRENT_SOURCE_DIR}}/Include)\n", file=fp)

    # add the final library
    print(f"add_library({libName}", file=fp)
    for tgt in tgtList:
        print(f"    $<TARGET_OBJECTS:{tgt}>", file=fp)
    print(")", file=fp)