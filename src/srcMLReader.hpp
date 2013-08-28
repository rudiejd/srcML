
#include <libxml/xmlreader.h>

#include <string>

#ifndef INCLUDED_SRCML_READER_HPP
#define INCLUDED_SRCML_READER_HPP

class srcMLReader {

  xmlTextReaderPtr reader;

public:

  srcMLReader(const char * filename);
  ~srcMLReader();

  std::string * read();
  

};

#endif
