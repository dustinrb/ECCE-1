/*
 *
 *  Copyright (C) 2000 Silicon Graphics, Inc.  All Rights Reserved. 
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  Further, this software is distributed without any warranty that it is
 *  free of the rightful claim of any third person regarding infringement
 *  or the like.  Any license provided herein, whether implied or
 *  otherwise, applies only to this software file.  Patent licenses, if
 *  any, provided herein do not apply to combinations of this program with
 *  other software, or any other product whatsoever.
 * 
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
 *  Mountain View, CA  94043, or:
 * 
 *  http://www.sgi.com 
 * 
 *  For further information regarding this notice, see: 
 * 
 *  http://oss.sgi.com/projects/GenInfo/NoticeExplan/
 *
 */

/*
 * Copyright (C) 1990,91   Silicon Graphics, Inc.
 *
 _______________________________________________________________________
 ______________  S I L I C O N   G R A P H I C S   I N C .  ____________
 |
 |   $Revision: 22116 $
 |
 |   Classes:
 |      Bunches of nurbs code
 |
 |   Author(s)          : Gavin Bell
 |
 ______________  S I L I C O N   G R A P H I C S   I N C .  ____________
 _______________________________________________________________________
 */

#include "SoAddPrefix.hpp"
#include "arc.inc"
#include "arcsorter.inc"
#include "arctess.inc"
#include "backend.inc"
#include "basiccrveval.inc"
#include "basicsurfeval.inc"
#include "bin.inc"
#include "bufpool.inc"
#include "cachingeval.inc"
#include "ccw.inc"
#include "coveandtiler.inc"
#include "curve.inc"
#include "curvelist.inc"
#include "curvesub.inc"
#include "displaylist.inc"
#include "flist.inc"
#include "flistsorter.inc"
#include "hull.inc"
#include "intersect.inc"
#include "knotvector.inc"
#include "mapdesc.inc"
#include "mapdescv.inc"
#include "maplist.inc"
#include "mesher.inc"
#include "monotonizer.inc"
#include "mycode.inc"
#include "nurbsinterfac.inc"
#include "nurbstess.inc"
#include "patch.inc"
#include "patchlist.inc"
#include "quilt.inc"
#include "reader.inc"
#include "renderhints.inc"
#include "slicer.inc"
#include "sorter.inc"
#include "splitarcs.inc"
#include "subdivider.inc"
#include "tobezier.inc"
#include "trimline.inc"
#include "trimregion.inc"
#include "trimvertpool.inc"
#include "uarray.inc"
#include "varray.inc"