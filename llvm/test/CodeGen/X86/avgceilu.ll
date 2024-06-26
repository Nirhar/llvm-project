; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse4.1 | FileCheck %s --check-prefixes=SSE,SSE4
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-- -mcpu=x86-64-v4 | FileCheck %s --check-prefixes=AVX,AVX512

;
; 128-bit vectors
;

define <16 x i8> @test_fixed_v16i8(<16 x i8> %a0, <16 x i8> %a1) nounwind {
; SSE-LABEL: test_fixed_v16i8:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_fixed_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpavgb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %or = or <16 x i8> %a0, %a1
  %xor = xor <16 x i8> %a0, %a1
  %shift = lshr <16 x i8> %xor, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %res = sub <16 x i8> %or, %shift
  ret <16 x i8> %res
}

define <16 x i8> @test_ext_v16i8(<16 x i8> %a0, <16 x i8> %a1) nounwind {
; SSE-LABEL: test_ext_v16i8:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_ext_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpavgb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x0 = zext <16 x i8> %a0 to <16 x i16>
  %x1 = zext <16 x i8> %a1 to <16 x i16>
  %sum = add <16 x i16> %x0, %x1
  %inc = add <16 x i16> %sum, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %shift = lshr <16 x i16> %inc, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = trunc <16 x i16> %shift to <16 x i8>
  ret <16 x i8> %res
}

define <8 x i16> @test_fixed_v8i16(<8 x i16> %a0, <8 x i16> %a1) nounwind {
; SSE-LABEL: test_fixed_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_fixed_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpavgw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %or = or <8 x i16> %a0, %a1
  %xor = xor <8 x i16> %a1, %a0
  %shift = lshr <8 x i16> %xor, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = sub <8 x i16> %or, %shift
  ret <8 x i16> %res
}

define <8 x i16> @test_ext_v8i16(<8 x i16> %a0, <8 x i16> %a1) nounwind {
; SSE-LABEL: test_ext_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_ext_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpavgw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x0 = zext <8 x i16> %a0 to <8 x i32>
  %x1 = zext <8 x i16> %a1 to <8 x i32>
  %sum = add <8 x i32> %x0, %x1
  %inc = add <8 x i32> %sum, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %shift = lshr <8 x i32> %inc, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %res = trunc <8 x i32> %shift to <8 x i16>
  ret <8 x i16> %res
}

define <4 x i32> @test_fixed_v4i32(<4 x i32> %a0, <4 x i32> %a1) nounwind {
; SSE-LABEL: test_fixed_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    por %xmm1, %xmm2
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psubd %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_fixed_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm0, %xmm2, %xmm0
; AVX-NEXT:    retq
  %or = or <4 x i32> %a0, %a1
  %xor = xor <4 x i32> %a1, %a0
  %shift = lshr <4 x i32> %xor, <i32 1, i32 1, i32 1, i32 1>
  %res = sub <4 x i32> %or, %shift
  ret <4 x i32> %res
}

define <4 x i32> @test_ext_v4i32(<4 x i32> %a0, <4 x i32> %a1) nounwind {
; SSE-LABEL: test_ext_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    por %xmm1, %xmm2
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psubd %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_ext_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm0, %xmm2, %xmm0
; AVX-NEXT:    retq
  %x0 = zext <4 x i32> %a0 to <4 x i64>
  %x1 = zext <4 x i32> %a1 to <4 x i64>
  %sum = add <4 x i64> %x0, %x1
  %inc = add <4 x i64> %sum, <i64 1, i64 1, i64 1, i64 1>
  %shift = lshr <4 x i64> %inc, <i64 1, i64 1, i64 1, i64 1>
  %res = trunc <4 x i64> %shift to <4 x i32>
  ret <4 x i32> %res
}

define <2 x i64> @test_fixed_v2i64(<2 x i64> %a0, <2 x i64> %a1) nounwind {
; SSE-LABEL: test_fixed_v2i64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    por %xmm1, %xmm2
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psubq %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_fixed_v2i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX-NEXT:    vpsubq %xmm0, %xmm2, %xmm0
; AVX-NEXT:    retq
  %or = or <2 x i64> %a0, %a1
  %xor = xor <2 x i64> %a1, %a0
  %shift = lshr <2 x i64> %xor, <i64 1, i64 1>
  %res = sub <2 x i64> %or, %shift
  ret <2 x i64> %res
}

define <2 x i64> @test_ext_v2i64(<2 x i64> %a0, <2 x i64> %a1) nounwind {
; SSE-LABEL: test_ext_v2i64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    por %xmm1, %xmm2
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psubq %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_ext_v2i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX-NEXT:    vpsubq %xmm0, %xmm2, %xmm0
; AVX-NEXT:    retq
  %x0 = zext <2 x i64> %a0 to <2 x i128>
  %x1 = zext <2 x i64> %a1 to <2 x i128>
  %sum = add <2 x i128> %x0, %x1
  %inc = add <2 x i128> %sum, <i128 1, i128 1>
  %shift = lshr <2 x i128> %inc, <i128 1, i128 1>
  %res = trunc <2 x i128> %shift to <2 x i64>
  ret <2 x i64> %res
}

;
; 256-bit vectors
;

define <32 x i8> @test_fixed_v32i8(<32 x i8> %a0, <32 x i8> %a1) nounwind {
; SSE-LABEL: test_fixed_v32i8:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgb %xmm2, %xmm0
; SSE-NEXT:    pavgb %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpavgb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpavgb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v32i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v32i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %or = or <32 x i8> %a0, %a1
  %xor = xor <32 x i8> %a0, %a1
  %shift = lshr <32 x i8> %xor, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %res = sub <32 x i8> %or, %shift
  ret <32 x i8> %res
}

define <32 x i8> @test_ext_v32i8(<32 x i8> %a0, <32 x i8> %a1) nounwind {
; SSE-LABEL: test_ext_v32i8:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgb %xmm2, %xmm0
; SSE-NEXT:    pavgb %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpavgb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpavgb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v32i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v32i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %x0 = zext <32 x i8> %a0 to <32 x i16>
  %x1 = zext <32 x i8> %a1 to <32 x i16>
  %sum = add <32 x i16> %x0, %x1
  %inc = add <32 x i16> %sum, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %shift = lshr <32 x i16> %inc, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = trunc <32 x i16> %shift to <32 x i8>
  ret <32 x i8> %res
}

define <16 x i16> @test_fixed_v16i16(<16 x i16> %a0, <16 x i16> %a1) nounwind {
; SSE-LABEL: test_fixed_v16i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgw %xmm2, %xmm0
; SSE-NEXT:    pavgw %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpavgw %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpavgw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v16i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %or = or <16 x i16> %a0, %a1
  %xor = xor <16 x i16> %a1, %a0
  %shift = lshr <16 x i16> %xor, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = sub <16 x i16> %or, %shift
  ret <16 x i16> %res
}

define <16 x i16> @test_ext_v16i16(<16 x i16> %a0, <16 x i16> %a1) nounwind {
; SSE-LABEL: test_ext_v16i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgw %xmm2, %xmm0
; SSE-NEXT:    pavgw %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpavgw %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpavgw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v16i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %x0 = zext <16 x i16> %a0 to <16 x i32>
  %x1 = zext <16 x i16> %a1 to <16 x i32>
  %sum = add <16 x i32> %x0, %x1
  %inc = add <16 x i32> %sum, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %shift = lshr <16 x i32> %inc, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %res = trunc <16 x i32> %shift to <16 x i16>
  ret <16 x i16> %res
}

define <8 x i32> @test_fixed_v8i32(<8 x i32> %a0, <8 x i32> %a1) nounwind {
; SSE-LABEL: test_fixed_v8i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm4
; SSE-NEXT:    por %xmm2, %xmm4
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psubd %xmm0, %xmm4
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    pxor %xmm3, %xmm1
; SSE-NEXT:    psrld $1, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm2
; SSE-NEXT:    movdqa %xmm4, %xmm0
; SSE-NEXT:    movdqa %xmm2, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm3
; AVX1-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubd %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm0, %xmm2, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v8i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrld $1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubd %ymm0, %ymm2, %ymm0
; AVX512-NEXT:    retq
  %or = or <8 x i32> %a0, %a1
  %xor = xor <8 x i32> %a1, %a0
  %shift = lshr <8 x i32> %xor, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %res = sub <8 x i32> %or, %shift
  ret <8 x i32> %res
}

define <8 x i32> @test_ext_v8i32(<8 x i32> %a0, <8 x i32> %a1) nounwind {
; SSE-LABEL: test_ext_v8i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm4
; SSE-NEXT:    por %xmm2, %xmm4
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psubd %xmm0, %xmm4
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    pxor %xmm3, %xmm1
; SSE-NEXT:    psrld $1, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm2
; SSE-NEXT:    movdqa %xmm4, %xmm0
; SSE-NEXT:    movdqa %xmm2, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm3
; AVX1-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubd %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm0, %xmm2, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v8i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrld $1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubd %ymm0, %ymm2, %ymm0
; AVX512-NEXT:    retq
  %x0 = zext <8 x i32> %a0 to <8 x i64>
  %x1 = zext <8 x i32> %a1 to <8 x i64>
  %sum = add <8 x i64> %x0, %x1
  %inc = add <8 x i64> %sum, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %shift = lshr <8 x i64> %inc, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %res = trunc <8 x i64> %shift to <8 x i32>
  ret <8 x i32> %res
}

define <4 x i64> @test_fixed_v4i64(<4 x i64> %a0, <4 x i64> %a1) nounwind {
; SSE-LABEL: test_fixed_v4i64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm4
; SSE-NEXT:    por %xmm2, %xmm4
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psubq %xmm0, %xmm4
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    pxor %xmm3, %xmm1
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    psubq %xmm1, %xmm2
; SSE-NEXT:    movdqa %xmm4, %xmm0
; SSE-NEXT:    movdqa %xmm2, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm3
; AVX1-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubq %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm2, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlq $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v4i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrlq $1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX512-NEXT:    retq
  %or = or <4 x i64> %a0, %a1
  %xor = xor <4 x i64> %a1, %a0
  %shift = lshr <4 x i64> %xor, <i64 1, i64 1, i64 1, i64 1>
  %res = sub <4 x i64> %or, %shift
  ret <4 x i64> %res
}

define <4 x i64> @test_ext_v4i64(<4 x i64> %a0, <4 x i64> %a1) nounwind {
; SSE-LABEL: test_ext_v4i64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm4
; SSE-NEXT:    por %xmm2, %xmm4
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psubq %xmm0, %xmm4
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    pxor %xmm3, %xmm1
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    psubq %xmm1, %xmm2
; SSE-NEXT:    movdqa %xmm4, %xmm0
; SSE-NEXT:    movdqa %xmm2, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm3
; AVX1-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubq %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm2, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlq $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v4i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrlq $1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX512-NEXT:    retq
  %x0 = zext <4 x i64> %a0 to <4 x i128>
  %x1 = zext <4 x i64> %a1 to <4 x i128>
  %sum = add <4 x i128> %x0, %x1
  %inc = add <4 x i128> %sum, <i128 1, i128 1, i128 1, i128 1>
  %shift = lshr <4 x i128> %inc, <i128 1, i128 1, i128 1, i128 1>
  %res = trunc <4 x i128> %shift to <4 x i64>
  ret <4 x i64> %res
}

;
; 512-bit vectors
;

define <64 x i8> @test_fixed_v64i8(<64 x i8> %a0, <64 x i8> %a1) nounwind {
; SSE-LABEL: test_fixed_v64i8:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgb %xmm4, %xmm0
; SSE-NEXT:    pavgb %xmm5, %xmm1
; SSE-NEXT:    pavgb %xmm6, %xmm2
; SSE-NEXT:    pavgb %xmm7, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v64i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm5
; AVX1-NEXT:    vpavgb %xmm4, %xmm5, %xmm4
; AVX1-NEXT:    vpavgb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm3, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm4
; AVX1-NEXT:    vpavgb %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpavgb %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v64i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgb %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpavgb %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v64i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgb %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    retq
  %or = or <64 x i8> %a0, %a1
  %xor = xor <64 x i8> %a0, %a1
  %shift = lshr <64 x i8> %xor, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %res = sub <64 x i8> %or, %shift
  ret <64 x i8> %res
}

define <64 x i8> @test_ext_v64i8(<64 x i8> %a0, <64 x i8> %a1) nounwind {
; SSE-LABEL: test_ext_v64i8:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgb %xmm4, %xmm0
; SSE-NEXT:    pavgb %xmm5, %xmm1
; SSE-NEXT:    pavgb %xmm6, %xmm2
; SSE-NEXT:    pavgb %xmm7, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v64i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm5
; AVX1-NEXT:    vpavgb %xmm4, %xmm5, %xmm4
; AVX1-NEXT:    vpavgb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm3, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm4
; AVX1-NEXT:    vpavgb %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpavgb %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v64i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgb %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpavgb %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v64i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgb %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    retq
  %x0 = zext <64 x i8> %a0 to <64 x i16>
  %x1 = zext <64 x i8> %a1 to <64 x i16>
  %sum = add <64 x i16> %x0, %x1
  %inc = add <64 x i16> %sum, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %shift = lshr <64 x i16> %inc, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = trunc <64 x i16> %shift to <64 x i8>
  ret <64 x i8> %res
}

define <32 x i16> @test_fixed_v32i16(<32 x i16> %a0, <32 x i16> %a1) nounwind {
; SSE-LABEL: test_fixed_v32i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgw %xmm4, %xmm0
; SSE-NEXT:    pavgw %xmm5, %xmm1
; SSE-NEXT:    pavgw %xmm6, %xmm2
; SSE-NEXT:    pavgw %xmm7, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v32i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm5
; AVX1-NEXT:    vpavgw %xmm4, %xmm5, %xmm4
; AVX1-NEXT:    vpavgw %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm3, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm4
; AVX1-NEXT:    vpavgw %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpavgw %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v32i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpavgw %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v32i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgw %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    retq
  %or = or <32 x i16> %a0, %a1
  %xor = xor <32 x i16> %a1, %a0
  %shift = lshr <32 x i16> %xor, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = sub <32 x i16> %or, %shift
  ret <32 x i16> %res
}

define <32 x i16> @test_ext_v32i16(<32 x i16> %a0, <32 x i16> %a1) nounwind {
; SSE-LABEL: test_ext_v32i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pavgw %xmm4, %xmm0
; SSE-NEXT:    pavgw %xmm5, %xmm1
; SSE-NEXT:    pavgw %xmm6, %xmm2
; SSE-NEXT:    pavgw %xmm7, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v32i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm5
; AVX1-NEXT:    vpavgw %xmm4, %xmm5, %xmm4
; AVX1-NEXT:    vpavgw %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm3, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm4
; AVX1-NEXT:    vpavgw %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpavgw %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v32i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpavgw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpavgw %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v32i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpavgw %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    retq
  %x0 = zext <32 x i16> %a0 to <32 x i32>
  %x1 = zext <32 x i16> %a1 to <32 x i32>
  %sum = add <32 x i32> %x0, %x1
  %inc = add <32 x i32> %sum, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %shift = lshr <32 x i32> %inc, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %res = trunc <32 x i32> %shift to <32 x i16>
  ret <32 x i16> %res
}

define <16 x i32> @test_fixed_v16i32(<16 x i32> %a0, <16 x i32> %a1) nounwind {
; SSE-LABEL: test_fixed_v16i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm8
; SSE-NEXT:    por %xmm4, %xmm8
; SSE-NEXT:    pxor %xmm4, %xmm0
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psubd %xmm0, %xmm8
; SSE-NEXT:    movdqa %xmm1, %xmm4
; SSE-NEXT:    por %xmm5, %xmm4
; SSE-NEXT:    pxor %xmm5, %xmm1
; SSE-NEXT:    psrld $1, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm4
; SSE-NEXT:    movdqa %xmm2, %xmm5
; SSE-NEXT:    por %xmm6, %xmm5
; SSE-NEXT:    pxor %xmm6, %xmm2
; SSE-NEXT:    psrld $1, %xmm2
; SSE-NEXT:    psubd %xmm2, %xmm5
; SSE-NEXT:    movdqa %xmm3, %xmm6
; SSE-NEXT:    por %xmm7, %xmm6
; SSE-NEXT:    pxor %xmm7, %xmm3
; SSE-NEXT:    psrld $1, %xmm3
; SSE-NEXT:    psubd %xmm3, %xmm6
; SSE-NEXT:    movdqa %xmm8, %xmm0
; SSE-NEXT:    movdqa %xmm4, %xmm1
; SSE-NEXT:    movdqa %xmm5, %xmm2
; SSE-NEXT:    movdqa %xmm6, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v16i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm2, %ymm0, %ymm4
; AVX1-NEXT:    vextractf128 $1, %ymm4, %xmm5
; AVX1-NEXT:    vxorps %ymm2, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX1-NEXT:    vpsrld $1, %xmm2, %xmm2
; AVX1-NEXT:    vpsubd %xmm2, %xmm5, %xmm2
; AVX1-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm0, %xmm4, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vxorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm3
; AVX1-NEXT:    vpsrld $1, %xmm3, %xmm3
; AVX1-NEXT:    vpsubd %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubd %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm3, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v16i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm2, %ymm0, %ymm4
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm0, %ymm4, %ymm0
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm2
; AVX2-NEXT:    vpxor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpsrld $1, %ymm1, %ymm1
; AVX2-NEXT:    vpsubd %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v16i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpord %zmm1, %zmm0, %zmm2
; AVX512-NEXT:    vpxord %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrld $1, %zmm0, %zmm0
; AVX512-NEXT:    vpsubd %zmm0, %zmm2, %zmm0
; AVX512-NEXT:    retq
  %or = or <16 x i32> %a0, %a1
  %xor = xor <16 x i32> %a1, %a0
  %shift = lshr <16 x i32> %xor, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %res = sub <16 x i32> %or, %shift
  ret <16 x i32> %res
}

define <16 x i32> @test_ext_v16i32(<16 x i32> %a0, <16 x i32> %a1) nounwind {
; SSE-LABEL: test_ext_v16i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm8
; SSE-NEXT:    por %xmm4, %xmm8
; SSE-NEXT:    pxor %xmm4, %xmm0
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psubd %xmm0, %xmm8
; SSE-NEXT:    movdqa %xmm1, %xmm4
; SSE-NEXT:    por %xmm5, %xmm4
; SSE-NEXT:    pxor %xmm5, %xmm1
; SSE-NEXT:    psrld $1, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm4
; SSE-NEXT:    movdqa %xmm2, %xmm5
; SSE-NEXT:    por %xmm6, %xmm5
; SSE-NEXT:    pxor %xmm6, %xmm2
; SSE-NEXT:    psrld $1, %xmm2
; SSE-NEXT:    psubd %xmm2, %xmm5
; SSE-NEXT:    movdqa %xmm3, %xmm6
; SSE-NEXT:    por %xmm7, %xmm6
; SSE-NEXT:    pxor %xmm7, %xmm3
; SSE-NEXT:    psrld $1, %xmm3
; SSE-NEXT:    psubd %xmm3, %xmm6
; SSE-NEXT:    movdqa %xmm8, %xmm0
; SSE-NEXT:    movdqa %xmm4, %xmm1
; SSE-NEXT:    movdqa %xmm5, %xmm2
; SSE-NEXT:    movdqa %xmm6, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v16i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm2, %ymm0, %ymm4
; AVX1-NEXT:    vextractf128 $1, %ymm4, %xmm5
; AVX1-NEXT:    vxorps %ymm2, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX1-NEXT:    vpsrld $1, %xmm2, %xmm2
; AVX1-NEXT:    vpsubd %xmm2, %xmm5, %xmm2
; AVX1-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm0, %xmm4, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vxorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm3
; AVX1-NEXT:    vpsrld $1, %xmm3, %xmm3
; AVX1-NEXT:    vpsubd %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubd %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm3, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v16i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm2, %ymm0, %ymm4
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm0, %ymm4, %ymm0
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm2
; AVX2-NEXT:    vpxor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpsrld $1, %ymm1, %ymm1
; AVX2-NEXT:    vpsubd %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v16i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpord %zmm1, %zmm0, %zmm2
; AVX512-NEXT:    vpxord %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrld $1, %zmm0, %zmm0
; AVX512-NEXT:    vpsubd %zmm0, %zmm2, %zmm0
; AVX512-NEXT:    retq
  %x0 = zext <16 x i32> %a0 to <16 x i64>
  %x1 = zext <16 x i32> %a1 to <16 x i64>
  %sum = add <16 x i64> %x0, %x1
  %inc = add <16 x i64> %sum, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %shift = lshr <16 x i64> %inc, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %res = trunc <16 x i64> %shift to <16 x i32>
  ret <16 x i32> %res
}

define <8 x i64> @test_fixed_v8i64(<8 x i64> %a0, <8 x i64> %a1) nounwind {
; SSE-LABEL: test_fixed_v8i64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm8
; SSE-NEXT:    por %xmm4, %xmm8
; SSE-NEXT:    pxor %xmm4, %xmm0
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psubq %xmm0, %xmm8
; SSE-NEXT:    movdqa %xmm1, %xmm4
; SSE-NEXT:    por %xmm5, %xmm4
; SSE-NEXT:    pxor %xmm5, %xmm1
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    psubq %xmm1, %xmm4
; SSE-NEXT:    movdqa %xmm2, %xmm5
; SSE-NEXT:    por %xmm6, %xmm5
; SSE-NEXT:    pxor %xmm6, %xmm2
; SSE-NEXT:    psrlq $1, %xmm2
; SSE-NEXT:    psubq %xmm2, %xmm5
; SSE-NEXT:    movdqa %xmm3, %xmm6
; SSE-NEXT:    por %xmm7, %xmm6
; SSE-NEXT:    pxor %xmm7, %xmm3
; SSE-NEXT:    psrlq $1, %xmm3
; SSE-NEXT:    psubq %xmm3, %xmm6
; SSE-NEXT:    movdqa %xmm8, %xmm0
; SSE-NEXT:    movdqa %xmm4, %xmm1
; SSE-NEXT:    movdqa %xmm5, %xmm2
; SSE-NEXT:    movdqa %xmm6, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_fixed_v8i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm2, %ymm0, %ymm4
; AVX1-NEXT:    vextractf128 $1, %ymm4, %xmm5
; AVX1-NEXT:    vxorps %ymm2, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX1-NEXT:    vpsrlq $1, %xmm2, %xmm2
; AVX1-NEXT:    vpsubq %xmm2, %xmm5, %xmm2
; AVX1-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm4, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vxorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm3
; AVX1-NEXT:    vpsrlq $1, %xmm3, %xmm3
; AVX1-NEXT:    vpsubq %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubq %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm3, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_fixed_v8i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm2, %ymm0, %ymm4
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlq $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm4, %ymm0
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm2
; AVX2-NEXT:    vpxor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpsrlq $1, %ymm1, %ymm1
; AVX2-NEXT:    vpsubq %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_fixed_v8i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm2
; AVX512-NEXT:    vpxorq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrlq $1, %zmm0, %zmm0
; AVX512-NEXT:    vpsubq %zmm0, %zmm2, %zmm0
; AVX512-NEXT:    retq
  %or = or <8 x i64> %a0, %a1
  %xor = xor <8 x i64> %a1, %a0
  %shift = lshr <8 x i64> %xor, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %res = sub <8 x i64> %or, %shift
  ret <8 x i64> %res
}

define <8 x i64> @test_ext_v8i64(<8 x i64> %a0, <8 x i64> %a1) nounwind {
; SSE-LABEL: test_ext_v8i64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm8
; SSE-NEXT:    por %xmm4, %xmm8
; SSE-NEXT:    pxor %xmm4, %xmm0
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psubq %xmm0, %xmm8
; SSE-NEXT:    movdqa %xmm1, %xmm4
; SSE-NEXT:    por %xmm5, %xmm4
; SSE-NEXT:    pxor %xmm5, %xmm1
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    psubq %xmm1, %xmm4
; SSE-NEXT:    movdqa %xmm2, %xmm5
; SSE-NEXT:    por %xmm6, %xmm5
; SSE-NEXT:    pxor %xmm6, %xmm2
; SSE-NEXT:    psrlq $1, %xmm2
; SSE-NEXT:    psubq %xmm2, %xmm5
; SSE-NEXT:    movdqa %xmm3, %xmm6
; SSE-NEXT:    por %xmm7, %xmm6
; SSE-NEXT:    pxor %xmm7, %xmm3
; SSE-NEXT:    psrlq $1, %xmm3
; SSE-NEXT:    psubq %xmm3, %xmm6
; SSE-NEXT:    movdqa %xmm8, %xmm0
; SSE-NEXT:    movdqa %xmm4, %xmm1
; SSE-NEXT:    movdqa %xmm5, %xmm2
; SSE-NEXT:    movdqa %xmm6, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_ext_v8i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm2, %ymm0, %ymm4
; AVX1-NEXT:    vextractf128 $1, %ymm4, %xmm5
; AVX1-NEXT:    vxorps %ymm2, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX1-NEXT:    vpsrlq $1, %xmm2, %xmm2
; AVX1-NEXT:    vpsubq %xmm2, %xmm5, %xmm2
; AVX1-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm4, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm4
; AVX1-NEXT:    vxorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm3
; AVX1-NEXT:    vpsrlq $1, %xmm3, %xmm3
; AVX1-NEXT:    vpsubq %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubq %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm3, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_ext_v8i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm2, %ymm0, %ymm4
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlq $1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm4, %ymm0
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm2
; AVX2-NEXT:    vpxor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpsrlq $1, %ymm1, %ymm1
; AVX2-NEXT:    vpsubq %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_ext_v8i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm2
; AVX512-NEXT:    vpxorq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrlq $1, %zmm0, %zmm0
; AVX512-NEXT:    vpsubq %zmm0, %zmm2, %zmm0
; AVX512-NEXT:    retq
  %x0 = zext <8 x i64> %a0 to <8 x i128>
  %x1 = zext <8 x i64> %a1 to <8 x i128>
  %sum = add <8 x i128> %x0, %x1
  %inc = add <8 x i128> %sum, <i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1>
  %shift = lshr <8 x i128> %inc, <i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1>
  %res = trunc <8 x i128> %shift to <8 x i64>
  ret <8 x i64> %res
}

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; SSE2: {{.*}}
; SSE4: {{.*}}
