################################################################################
# FILENAME:  Makefile (generated by genmake)
#
#
# DESCRIPTION:
#   You should leave things in the order in which genmake wrote them.  Sections
#   where values can be modified are marked as MODIFIABLE.    
#
#   For an example of how to set up platform specific flags, see the bottom of
#   $ECCE_MAKEINC_DIR/Makefile.defs.
#
# CUSTOMIZATIONS:
################################################################################

# genmake:  The name of the library this Makefile builds
LIBRARY := libeccewxplotctrl.a
 
# genmake:  include all ECCE definitions
include $(ECCE_MAKEINC_DIR)/Makefile.defs
 
# genmake:  includes for packages, dependencies, rules
include $(ECCE_MAKEINC_DIR)/Makefile.wx

# genmake:  ALL MODIFIABLE
# When there is a mix of C++ (.C extension) and C (.c extension) source code
# different SRCS and OBJS variables need to be defined for each with the
# regular SRCS and OBJS variables as the union of the separate variables
SRCS1  = $(shell ls *.C 2>/dev/null)
SRCS2  = $(shell ls *.c 2>/dev/null)
SRCS   = $(SRCS1) $(SRCS2)
OBJS1  = $(patsubst %.C, $(OBJ_PATH)/%.o, $(SRCS1))
OBJS2  = $(patsubst %.c, $(OBJ_PATH)/%.o, $(SRCS2))
OBJS   = $(OBJS1) $(OBJS2)
IFLAGS := $(ECCE_IFLAGS) $(WX_IFLAGS) 
IFLAGS += $(shell pkg-config --cflags-only-I gtk+-2.0)
CFLAGS := $(ECCE_CFLAGS)
CCFLAGS := $(ECCE_CCFLAGS)
 
default: $(OBJ_PATH) $(SRCS1:%.C=.%.D) $(SRCS2:%.c=.%.D) $(LIB_PATH)/$(LIBRARY)

compile: $(OBJ_PATH) $(SRCS1:%.C=.%.D) $(SRCS2:%.c=.%.D) $(OBJS1) $(OBJS2)

include $(shell ls .*.D)
include $(ECCE_MAKEINC_DIR)/Makefile.rules
