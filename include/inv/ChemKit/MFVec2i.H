/*
 * MFVec2i.h
 *
 *	This file defines the MFVec2i class.
 *
 * Copyright 1996, 1997, Silicon Graphics, Inc.
 * ALL RIGHTS RESERVED
 *
 * UNPUBLISHED -- Rights reserved under the copyright laws of the United
 * States.   Use of a copyright notice is precautionary only and does not
 * imply publication or disclosure.
 *
 * U.S. GOVERNMENT RESTRICTED RIGHTS LEGEND:
 * Use, duplication or disclosure by the Government is subject to restrictions
 * as set forth in FAR 52.227.19(c)(2) or subparagraph (c)(1)(ii) of the Rights
 * in Technical Data and Computer Software clause at DFARS 252.227-7013 and/or
 * in similar or successor clauses in the FAR, or the DOD or NASA FAR
 * Supplement.  Contractor/manufacturer is Silicon Graphics, Inc.,
 * 2011 N. Shoreline Blvd. Mountain View, CA 94039-7311.
 *
 * THE CONTENT OF THIS WORK CONTAINS CONFIDENTIAL AND PROPRIETARY
 * INFORMATION OF SILICON GRAPHICS, INC. ANY DUPLICATION, MODIFICATION,
 * DISTRIBUTION, OR DISCLOSURE IN ANY FORM, IN WHOLE, OR IN PART, IS STRICTLY
 * PROHIBITED WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF SILICON
 * GRAPHICS, INC.
 */
/**************************************************************************\
 *
 * OpenMOIV - C++ library for molecular visualization using Inventor.
 * Copyright (C) 2001-2003 Universitat Pompeu Fabra - Barcelona (Spain)
 * 
 * Developers: Interactive Technology Group (GTI)
 * Team: Josep Blat, Eduard Gonzalez, Sergi Gonzalez,
 *       Daniel Soto, Alejandro Ramirez, Oscar Civit.
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details (see the file 
 * LICENSE.LGPL at the root directory).
 *
 * REMARK: This library is a derived product.
 *         You need also to accept all other applicable licenses.
 * 
 * Homepage: http://www.tecn.upf.es/openMOIV/
 * Contact:  openmoiv@upf.es
 *
\**************************************************************************/

#ident "$Revision: 22148 $"

#ifndef  __MF_VEC2I_H__
#define  __MF_VEC2I_H__

#include "inv/fields/SoSubField.H"
#include "inv/SbLinear.H"

#include "inv/ChemKit/SbVecI.H"
#include "inv/ChemKit/ChemkitBasic.H"

//////////////////////////////////////////////////////////////////////////////
//
//  MFVec2i subclass of SoMField.
//
//////////////////////////////////////////////////////////////////////////////

// C-api: prefix=SoMV2i
class CHEMKIT_DLL_API MFVec2i : public SoMField {
    // Use standard field stuff
    SO_MFIELD_HEADER(MFVec2i, SbVec2i, const SbVec2i &);

  public:

    //
    // Some additional convenience functions:
    // 

    // Set values from array of arrays of 2 integers
    // C-api: name=SetIJs
    void        setValues(int start, int num, const int32_t ij[][2]);

    // Set one value from 2 integers
        // C-api: name=Set1I_J
    void        set1Value(int index, int32_t i, int32_t j);

    // Set one value from 2 integers in array
        // C-api: name=Set1IJ
    void        set1Value(int index, const int32_t ij[2]);

    // Set to one value from 2 integers
        // C-api: name=SetI_J
    void        setValue(int32_t i, int32_t j);

    // Set to one value from 2 integers in array
        // C-api: name=SetIJ
    void        setValue(const int32_t ijk[2]);
// --> util 
		int find(const int index, const int globalNumber) const;
		int count(int globalNumber) const;
		static void sortIndices(MFVec2i &listIndex, MFVec2i &newIndex,
			int32_t end_indicator, int32_t numberOfItems);
		void setNum(const int num);
// <-- util

  SoINTERNAL public:
    static void         initClass();

  private:

    // Write the values out as a block of data
    virtual void        writeBinaryValues(SoOutput *out) const;
    virtual SbBool      readBinaryValues(SoInput *in, int numToRead);
};

#endif /* !__MF_VEC2I_H__ */
