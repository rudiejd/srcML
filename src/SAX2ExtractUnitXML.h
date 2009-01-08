/*
  SAX2ExtractUnitXML.h

  Copyright (C) 2008 SDML (www.sdml.info)

  This file is part of the srcML translator.

  The srcML translator is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  The srcML translator is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with the srcML translator; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

  A SAX2 handler for libxml2 that converts input to ExtractUnitXML.  It performs
  a (attempted) identical copy of the input.  Typically used for part of
  an xml document, e.g., an individual subpart.  It can also be customized
  by overriding individual callbacks.
*/

#ifndef INCLUDED_SAX2EXTRACTUNITXML_H
#define INCLUDED_SAX2EXTRACTUNITXML_H

#include "SAX2Utilities.h"
#include <libxml/parser.h>
#include <libxml/xmlwriter.h>

class SAX2ExtractUnitXML {
 public:

  static int placescount;
  static int placesunit;

  static xmlSAXHandler factory();

  struct State {
    xmlParserCtxtPtr ctxt;
    int unit;
    long count;
    const char * root_filename;
    const char * ofilename;
    xmlCharEncodingHandlerPtr handler;
    int* poptions;
    const char* filename;      // output filename
    xmlTextWriterPtr writer;   // output text writer
    xmlOutputBufferPtr output;
    PROPERTIES_TYPE* nsv;
    PROPERTIES_TYPE* attrv;
  };

  // startElement for root
  static void startElementNsRoot(void* ctx, const xmlChar* localname, const xmlChar* prefix, const xmlChar* URI,
		    int nb_namespaces, const xmlChar** namespaces, int nb_attributes, int nb_defaulted,
		    const xmlChar** attributes);

  // startElement for root
  static void startElementNsUnit(void* ctx, const xmlChar* localname, const xmlChar* prefix, const xmlChar* URI,
		    int nb_namespaces, const xmlChar** namespaces, int nb_attributes, int nb_defaulted,
		    const xmlChar** attributes);

  static void endElementNs(void *ctx, const xmlChar *localname, const xmlChar *prefix, const xmlChar *URI);
};

#endif
