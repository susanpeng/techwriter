<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">




<xsl:output method="xml" indent="yes" doctype-system="../DTDs/manual.dtd" />


  <xsl:template match="/">
      <xsl:result-document href="../source/assign-3Yulin.xml" >
      <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="../xslt/helpmanual.xsl"</xsl:processing-instruction>
    <xsl:processing-instruction name="altova_sps">..\DTDs\helpmanual.sps </xsl:processing-instruction>

<xsl:processing-instruction name="altova_xslfo">..\xslt\helpmanualpdf.xslt </xsl:processing-instruction>
      <xsl:apply-templates/>
    </xsl:result-document>
    
  </xsl:template>
  
  <xsl:template match="text()">
  <!-- strip extra whitespace from text nodes
       (including leading and trailing whitespace) -->
  <xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="*">
  <!-- default element rule is identity transform -->
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="*[../text()[normalize-space(.) != '']]">
  <!-- but this template matches any element appearing in mixed content -->
  <xsl:variable name="textbefore"
       select="preceding-sibling::node()[1][self::text()]"/>
  <xsl:variable name="textafter"
       select="following-sibling::node()[1][self::text()]"/>
  <!-- Either of the preceding variables will be an empty node set 
       if the neighbor node is not text(), right? -->
  <xsl:variable name="prevchar"
       select="substring($textbefore, string-length($textbefore))"/>
  <xsl:variable name="nextchar"
       select="substring($textafter, 1, 1)"/>

  <!-- Now the action: -->
  <xsl:if test="$prevchar != normalize-space($prevchar)">
  <!-- If the original text had a space before, add one back -->
    <xsl:text> </xsl:text>
  </xsl:if>

  <xsl:copy>
  <!-- Copy the element over -->
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>

  <xsl:if test="$nextchar != normalize-space($nextchar)">
  <!-- If the original text had a space after, add one back -->
    <xsl:text> </xsl:text>
  </xsl:if>

</xsl:template>

</xsl:stylesheet>