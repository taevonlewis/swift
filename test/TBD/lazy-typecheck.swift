// RUN: %empty-directory(%t)
// RUN: split-file %s %t

// RUN: %target-swift-frontend -target arm64-apple-macosx10.13 -swift-version 5 %S/../Inputs/lazy_typecheck.swift -module-name lazy_typecheck -emit-module -emit-module-path /dev/null -emit-tbd-path %t/lazy_typecheck.tbd -enable-library-evolution -parse-as-library -package-name Package -experimental-lazy-typecheck -experimental-skip-all-function-bodies -experimental-serialize-external-decls-only
// RUN: %llvm-readtapi %t/lazy_typecheck.tbd %t/expected.tbd

// REQUIRES: OS=macosx

//--- expected.tbd
--- !tapi-tbd
tbd-version:     4
targets:         [ arm64-macos ]
flags:           [ not_app_extension_safe ]
install-name:    ''
current-version: 0
compatibility-version: 0
swift-abi-version: 7
exports:
  - targets:         [ arm64-macos ]
    symbols:         [ '_$s14lazy_typecheck10publicFuncSiyF', '_$s14lazy_typecheck11PublicProtoMp',
                        '_$s14lazy_typecheck11PublicProtoP3reqSiyFTj', '_$s14lazy_typecheck11PublicProtoP3reqSiyFTq',
                        '_$s14lazy_typecheck11PublicProtoTL', '_$s14lazy_typecheck11packageFuncSiyF',
                        '_$s14lazy_typecheck12PublicStructV12publicMethodSiyF', '_$s14lazy_typecheck12PublicStructVMa',
                        '_$s14lazy_typecheck12PublicStructVMn', '_$s14lazy_typecheck12PublicStructVN',
                        '_$s14lazy_typecheck13inlinableFuncSiyF', '_$s14lazy_typecheck24publicFuncWithDefaultArgyS2iF',
                        '_$s14lazy_typecheck30publicFuncWithOpaqueReturnTypeQryF',
                        '_$s14lazy_typecheck30publicFuncWithOpaqueReturnTypeQryFQOMQ',
                        '_$s14lazy_typecheck32constrainedGenericPublicFunctionyyxAA0E5ProtoRzlF' ]
...
