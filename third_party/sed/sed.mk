#-*-mode:makefile-gmake;indent-tabs-mode:t;tab-width:8;coding:utf-8-*-┐
#───vi: set et ft=make ts=8 tw=8 fenc=utf-8 :vi───────────────────────┘

PKGS += THIRD_PARTY_SED

THIRD_PARTY_SED_SRCS = $(THIRD_PARTY_SED_A_SRCS)
THIRD_PARTY_SED_HDRS = $(THIRD_PARTY_SED_A_HDRS)
THIRD_PARTY_SED_INCS = $(THIRD_PARTY_SED_A_INCS)
THIRD_PARTY_SED_BINS = $(THIRD_PARTY_SED_COMS) $(THIRD_PARTY_SED_COMS:%=%.dbg)
THIRD_PARTY_SED_COMS = o/$(MODE)/third_party/sed/sed.com

THIRD_PARTY_SED_ARTIFACTS += THIRD_PARTY_SED_A
THIRD_PARTY_SED = $(THIRD_PARTY_SED_A_DEPS) $(THIRD_PARTY_SED_A)
THIRD_PARTY_SED_A = o/$(MODE)/third_party/sed/sed.a
THIRD_PARTY_SED_A_FILES := $(wildcard third_party/sed/*)
THIRD_PARTY_SED_A_HDRS = $(filter %.h,$(THIRD_PARTY_SED_A_FILES))
THIRD_PARTY_SED_A_INCS = $(filter %.inc,$(THIRD_PARTY_SED_A_FILES))
THIRD_PARTY_SED_A_SRCS = $(filter %.c,$(THIRD_PARTY_SED_A_FILES))
THIRD_PARTY_SED_A_OBJS = $(THIRD_PARTY_SED_A_SRCS:%.c=o/$(MODE)/%.o)

THIRD_PARTY_SED_A_DIRECTDEPS =				\
	LIBC_FMT					\
	LIBC_INTRIN					\
	LIBC_MEM					\
	LIBC_NEXGEN32E					\
	LIBC_RUNTIME					\
	LIBC_CALLS					\
	LIBC_STDIO					\
	LIBC_SYSV					\
	LIBC_STR					\
	LIBC_LOG					\
	LIBC_STUBS					\
	THIRD_PARTY_GETOPT				\
	THIRD_PARTY_REGEX

THIRD_PARTY_SED_A_DEPS :=				\
	$(call uniq,$(foreach x,$(THIRD_PARTY_SED_A_DIRECTDEPS),$($(x))))

THIRD_PARTY_SED_A_CHECKS =				\
	$(THIRD_PARTY_SED_A).pkg			\
	$(THIRD_PARTY_SED_A_HDRS:%=o/$(MODE)/%.ok)

$(THIRD_PARTY_SED_A):					\
		third_party/sed/			\
		$(THIRD_PARTY_SED_A).pkg		\
		$(THIRD_PARTY_SED_A_OBJS)

$(THIRD_PARTY_SED_A).pkg:				\
		$(THIRD_PARTY_SED_A_OBJS)		\
		$(foreach x,$(THIRD_PARTY_SED_A_DIRECTDEPS),$($(x)_A).pkg)

o/$(MODE)/third_party/sed/sed.com.dbg:			\
		$(THIRD_PARTY_SED)			\
		o/$(MODE)/third_party/sed/main.o	\
		$(CRT)					\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

THIRD_PARTY_SED_LIBS = $(foreach x,$(THIRD_PARTY_SED_ARTIFACTS),$($(x)))
THIRD_PARTY_SED_SRCS = $(foreach x,$(THIRD_PARTY_SED_ARTIFACTS),$($(x)_SRCS))
THIRD_PARTY_SED_CHECKS = $(foreach x,$(THIRD_PARTY_SED_ARTIFACTS),$($(x)_CHECKS))
THIRD_PARTY_SED_OBJS = $(foreach x,$(THIRD_PARTY_SED_ARTIFACTS),$($(x)_OBJS))
$(THIRD_PARTY_SED_OBJS): $(BUILD_FILES) third_party/sed/sed.mk

.PHONY: o/$(MODE)/third_party/sed
o/$(MODE)/third_party/sed:				\
		$(THIRD_PARTY_SED_BINS)			\
		$(THIRD_PARTY_SED_CHECKS)
