/**
 * @file srcml_create_archive_memory.c
 *
 * @copyright Copyright (C) 2013-2014 SDML (www.srcML.org)
 *
 * The srcML Toolkit is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * The srcML Toolkit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with the srcML Toolkit; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
  Example program of the use of the C API for srcML.

  Create an archive, file by file, with an output memory.
*/

#include "srcml.h"
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#ifdef _MSC_BUILD  
#include <io.h>
#include <windows_macros.hpp>
#else
#include <unistd.h>
#endif

int main(int argc, char* argv[]) {
    int i;
    struct srcml_archive* archive;
    struct srcml_unit* unit;
    char * s;
    int size;
    int srcml_input;

    /* create a new srcml archive structure */
    archive = srcml_create_archive();

    /* open a srcML archive for output */
    srcml_write_open_memory(archive, &s, &size);

    /* add all the files to the archive */
    for (i = 1; i < argc; ++i) {

        unit = srcml_create_unit(archive);

        /* Translate to srcml and append to the archive */
        char buffer[256];
        srcml_input = open(argv[i], O_RDONLY);
        int num_read = read(srcml_input, buffer, 256);
        close(srcml_input);
        srcml_unit_set_language(unit, srcml_archive_check_extension(archive, argv[i]));

        srcml_parse_unit_memory(unit, buffer, num_read);

        /* Translate to srcml and append to the archive */
        srcml_write_unit(archive, unit);

        srcml_free_unit(unit);
    }

    /* close the srcML archive */
    srcml_close_archive(archive);

    /* free the srcML archive data */
    srcml_free_archive(archive);

    /* now dump the contents of the archive */
    puts(s);
    free(s);

    return 0;
}
