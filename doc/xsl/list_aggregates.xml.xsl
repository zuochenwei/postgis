<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- ********************************************************************
	 ********************************************************************
	 Copyright 2010-2022, Regina Obe
	 License: BSD-3-Clause
	 Purpose: This is an xsl transform that generates file list_aggregates.xml.xsl which
	 includes index listing of aggregate functions.
	 It uses xml reference sections from reference.xml to then be processed by docbook
	 ******************************************************************** -->
	<xsl:output method="xml" indent="yes" encoding="utf-8" />

	<!-- We deal only with the reference chapter -->
	<xsl:template match="/">
		<xsl:apply-templates select="/book/chapter[@id='reference']" />
	</xsl:template>

	<xsl:template match="//chapter">

			<itemizedlist>
			<!-- Pull out the purpose section for each ref entry and strip whitespace and put in a variable to be tagged unto each function comment  -->
			<xsl:for-each select='//refentry'>
				<xsl:sort select="refnamediv/refname"/>
				<xsl:variable name='comment'>
					<xsl:value-of select="normalize-space(translate(translate(refnamediv/refpurpose,'&#x0d;&#x0a;', ' '), '&#09;', ' '))"/>
				</xsl:variable>
				<xsl:variable name="refid">
					<xsl:value-of select="@id" />
				</xsl:variable>
				<xsl:variable name="refname">
					<xsl:value-of select="refnamediv/refname" />
				</xsl:variable>

			<!-- For each function prototype if it takes a geometry set then catalog it as an aggregate function  -->

						<xsl:if test=".//paramdef[contains(type,' set')] or .//paramdef[contains(type,'geography set')] or
						.//paramdef[contains(type,'raster set')]">
							 <listitem><simpara><link linkend="{$refid}"><xsl:value-of select="$refname" /></link> - <xsl:value-of select="$comment" /></simpara></listitem>
						</xsl:if>
				</xsl:for-each>
			</itemizedlist>

	</xsl:template>

</xsl:stylesheet>
