/**
 * @file test_srcml_sax2_reader.cpp
 *
 * @copyright Copyright (C) 2013-2014 srcML, LLC. (www.srcML.org)
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

  Test cases for srcml_archive_create.
*/

#include <srcml.h>

#include <dassert.hpp>

int main(int argc, char* argv[]) {

    {
        srcml_archive* archive = srcml_archive_create();
        srcml_archive_set_src_encoding(archive, "e");
        srcml_archive_set_url(archive, "u");
        srcml_archive_set_version(archive, "v");
        srcml_archive_set_options(archive, 1 | 2);
        srcml_archive_set_tabstop(archive, 4);
/*e
        archive->attributes.push_back("a");
        archive->attributes.push_back("a");
        archive->options = 1 | 2;
        archive->tabstop = 4;
        srcml_archive_get_namespace_prefix(archive, 0) = "s";
        archive->prefixes.push_back("foo");
        archive->namespaces.push_back("bar");
        archive->user_macro_list.push_back("foo");
        archive->user_macro_list.push_back("bar");
        srcml_archive_register_file_extension(archive, "foo", "bar");
        archive->translator = (srcml_translator *)1;
        archive->reader = (srcml_sax2_reader *)1;
        archive->input = (xmlParserInputBufferPtr)1;
        transform trans;
        trans.type = SRCML_XPATH;
        trans.arguments.str = "//src:unit";
        archive->transformations.push_back(trans);
        archive->revision_number = SRCDIFF_REVISION_ORIGINAL;
*/
        srcml_archive* new_archive = srcml_archive_clone(archive);
        dassert(srcml_archive_get_src_encoding(new_archive), std::string("e"));
        dassert(srcml_archive_get_url(new_archive), std::string("u"));
        dassert(srcml_archive_get_version(new_archive), std::string("v"));
        dassert(srcml_archive_get_options(new_archive), (1 | 2));
        dassert(srcml_archive_get_tabstop(new_archive), 4);

/*
        dassert(new_archive->attributes.size(), 2);
        dassert(new_archive->attributes.at(0), "a");
        dassert(new_archive->attributes.at(1), "a");

        dassert(new_archive->options, (1 | 2));

        dassert(new_archive->tabstop, 4);
        dassert(srcml_archive_get_namespace_size(new_archive), 2);
        dassert(new_archive->namespaces.size(), 2);
        dassert(new_archive->registered_languages.size(), archive->registered_languages.size());

        dassert(new_srcml_archive_get_namespace_prefix(archive, 0), "s");
        dassert(srcml_archive_get_namespace_prefix(new_archive, 1), "foo");
        dassert(srcml_archive_get_namespace_uri(new_archive, 1), "bar");

        dassert(new_archive->user_macro_list.size(), 2);
        dassert(new_archive->user_macro_list.at(0), "foo");
        dassert(new_archive->user_macro_list.at(1), "bar");

        dassert(new_archive->translator, 0);
        dassert(new_archive->reader, 0);
        dassert(new_archive->input, 0);

        dassert(new_archive->transformations.size(), 0);

        dassert(*new_archive->revision_number, SRCDIFF_REVISION_ORIGINAL)

*/
        srcml_archive_free(archive);
        srcml_archive_free(new_archive);

    }

    {

        dassert(srcml_archive_clone(0), 0);

    }

    return 0;
}
