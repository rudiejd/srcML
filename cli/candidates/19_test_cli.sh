#!/bin/bash

# test framework
source $(dirname "$0")/framework_test.sh

# test extract_archive_unit

define input <<- 'INPUT'
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<unit xmlns="http://www.sdml.info/srcML/src" xmlns:lc="http://www.sdml.info/srcML/linecol" language="C++">

	<unit xmlns:cpp="http://www.sdml.info/srcML/cpp" language="Java" dir="sub" mytag=foo filename="a.cpp">
	<expr_stmt lc:line="1"><expr><name>a</name></expr>;</expr_stmt>
	</unit>

	<unit xmlns:cpp="http://www.sdml.info/srcML/cpp" language="Java" dir="sub" mytag=foo filename="b.cpp">
	<expr_stmt lc:line="1"><expr><name>b</name></expr>;</expr_stmt>
	</unit>

	<unit xmlns:cpp="http://www.sdml.info/srcML/cpp" dir="sub" mytag=foo filename="c.cpp">
	<expr_stmt lc:line="1"><expr><name>c</name></expr>;</expr_stmt>
	</unit>

	</unit>
	INPUT

define file1 <<- 'STDOUT'
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<unit xmlns="http://www.sdml.info/srcML/src" xmlns:lc="http://www.sdml.info/srcML/linecol" xmlns:cpp="http://www.sdml.info/srcML/cpp" language="C" dir="sub" filename="a.cpp" mytag=foo>
	</unit>
	STDOUT

define file2 <<- 'STDOUT'
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<unit xmlns="http://www.sdml.info/srcML/src" xmlns:lc="http://www.sdml.info/srcML/linecol" xmlns:cpp="http://www.sdml.info/srcML/cpp" language="Java" dir="sub" mytag=foo filename="b.cpp">
	</unit>
	STDOUT

define file3 <<- 'STDOUT'
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<unit xmlns="http://www.sdml.info/srcML/src" xmlns:lc="http://www.sdml.info/srcML/linecol" xmlns:cpp="http://www.sdml.info/srcML/cpp" language="C++" dir="sub" mytag=foo filename="c.cpp">
	</unit>
	STDOUT

srcml2src --xml --unit "1" - <<< "$input"

check 3<<< "$file1"

srcml2src --xml --unit "1" <<< "$input"

check 3<<< "$file1"

srcml2src --xml --unit "2" - <<< "$input"

check 3<<< "$file2"

srcml2src --xml --unit "2" <<< "$input"

check 3<<< "$file2"

srcml2src --xml --unit "3" - <<< "$input"

check 3<<< "$file3"

srcml2src --xml --unit "3" <<< "$input"

check 3<<< "$file3"

srcml2src --xml --unit "1" --get-filename <<< "$input"

check 3<<< "a.cpp"

srcml2src --xml --unit "2" --get-filename <<< "$input"

check 3<<< "b.cpp"

srcml2src --xml --unit "1" --get-directory <<< "$input"

check 3<<< "sub"

srcml2src --xml --unit "2" --get-directory <<< "$input"

check 3<<< "sub"

srcml2src --xml --unit "1" --get-language <<< "$input"

check 3<<< "C"

srcml2src --xml --unit "2" --get-language <<< "$input"

check 3<<< "Java"

