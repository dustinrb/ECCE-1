/*
 * MFVec3AtomSpec.h
 *
 *	This file defines the MFVec3AtomSpec class.
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

#ifndef  __MF_VEC3ATOMSPEC_H__
#define  __MF_VEC3ATOMSPEC_H__

#include "inv/fields/SoSubField.H"
#include "inv/SbLinear.H"

#include "inv/ChemKit/SbAtomSpec.H"
#include "inv/ChemKit/ChemkitBasic.H"

//////////////////////////////////////////////////////////////////////////////
//
//  MFVec3AtomSpec subclass of SoSField.
//
//////////////////////////////////////////////////////////////////////////////

class CHEMKIT_DLL_API MFVec3AtomSpec : public SoMField {
    // Use standard field stuff
    SO_MFIELD_HEADER(MFVec3AtomSpec, SbVec3AtomSpec, const SbVec3AtomSpec &);

  public:
    //
    // Some additional convenience functions:
    //

    // Set value from 3 SbAtomSpec's
    void        setValue(const SbAtomSpec &i, const SbAtomSpec &j,
                         const SbAtomSpec &k);

    // Set value from array of 3 SbAtomSpec's
    void        setValue(const SbAtomSpec ijk[3]);

    // Set value from 3 SbAtomSpec's
    void        set1Value(int index, const SbAtomSpec &i, const SbAtomSpec &j,
                          const SbAtomSpec &k);

    // Set value from array of 3 SbAtomSpec's
    void        set1Value(int index, const SbAtomSpec ijk[3]);

  SoINTERNAL public:
    static void         initClass();

    // Update a copied field to use the copy of each node if there is one
    virtual void    fixCopy(SbBool copyConnections);
  
    // Override this to also check the stored nodes
    virtual SbBool  referencesCopy() const;

  private:
    // Override this to maintain write-references in node
    virtual void    countWriteRefs(SoOutput *out) const;

    void setVal(short index, const SbVec3AtomSpec &newValue);
    SbBool readAtomSpec(SoInput *in, SbAtomSpec &as);
    void   writeAtomSpec(const SbAtomSpec &as, SoOutput *out) const;
};

#endif /* !__MF_VEC3ATOMSPEC_H__ */
