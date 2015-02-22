#!/bin/bash

# test framework
source $(dirname "$0")/framework_test.sh

# test on compressed files with .cpio.bz2 extension
define src <<- 'STDOUT'

	a;
	STDOUT

define foutput <<- 'STDOUT'
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<unit xmlns="http://www.sdml.info/srcML/src" revision="REVISION" filename="file://archive/a.cpp.cpio.bz2">

	<unit xmlns:cpp="http://www.sdml.info/srcML/cpp" revision="REVISION" language="C++" filename="archive/a.cpp">
	<expr_stmt><expr><name>a</name></expr>;</expr_stmt>
	</unit>

	</unit>
	STDOUT

define output <<- 'STDOUT'
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<unit xmlns="http://www.sdml.info/srcML/src" revision="REVISION">

	<unit xmlns:cpp="http://www.sdml.info/srcML/cpp" revision="REVISION" language="C++" filename="archive/a.cpp">
	<expr_stmt><expr><name>a</name></expr>;</expr_stmt>
	</unit>

	</unit>
	STDOUT


createfile archive/a.cpp "$src"
echo archive/a.cpp | tr " " "\n" | cpio -o > archive/a.cpp.cpio
bzip2 -c archive/a.cpp.cpio > archive/a.cpp.cpio.bz2

src2srcml archive/a.cpp.cpio.bz2 -o archive/a.cpp.xml
check archive/a.cpp.xml 3<<< "$foutput" 4<<< "1 block"

srcml archive/a.cpp.cpio.bz2
check 3<<< "$foutput"

srcml -l C++ < archive/a.cpp.cpio.bz2
check 3<<< "$output"

srcml -l C++ -o archive/a.cpp.xml < archive/a.cpp.cpio.bz2
check archive/a.cpp.xml 3<<< "$output"
