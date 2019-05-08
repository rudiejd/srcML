<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:src="http://www.srcML.org/srcML/src"
    xmlns="http://www.srcML.org/srcML/src"
    exclude-result-prefixes="src"
    version="1.0">

<!--
    insertstruct.xsl

    Inserts a struct around the contents in each unit
-->

<xsl:output method="xml" omit-xml-declaration="no" version="1.0" encoding="UTF-8" standalone="yes"/>

<!-- wrap the entire contents of the unit inside a block -->
<xsl:template match="src:unit">
<xsl:copy><xsl:copy-of select="@*"/>
<struct>struct <name>S</name> <block>{<public type="default"><xsl:copy-of select="*|text()"/></public>}</block>;</struct>
</xsl:copy>
</xsl:template>

</xsl:stylesheet>
