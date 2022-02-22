<?xml version='1.0' standalone='no'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
 >

<xsl:output name="letter-format" method="xhtml" indent="yes"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
            doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

<!-- 
*********************************************************************************************************				
					
* File: student_letter.xsl
*********************************************************************************************************-->



<!-- 
************************************************************************
* Template: LETTER
*	Last Revision: April 14, 2009 		
************************************************************************-->
<xsl:template match="/">
<!-- If any mcomment elements are present, output a separate page that contains the marker's comments. -->
 <xsl:if test="//mcomment">
    <xsl:result-document href="../Output/letterandresume/McommentLetter.html" format="letter-format">
  <xsl:call-template name="mcommentpage"/>
  </xsl:result-document>
    </xsl:if>
    <!-- Output an HTML page called letter.html. -->
 <xsl:result-document href="../Output/letterandresume/letter.html" format="letter-format">
	<html xmlns="http://www.w3.org/1999/xhtml">
      <head><title>Letter</title>
      <link rel="stylesheet"  type="text/css" href="stylesheets/letter.css"/></head>
      <body>
          <div class="lettermain">
       <xsl:apply-templates/>
    </div>
      </body>
    </html>
	 </xsl:result-document>
</xsl:template>	

<!-- 
************************************************************************
* Named Template for marker's comments page. Here we name the template so that it can be called from within another template. We call this template from the root template above. 
	
************************************************************************-->
<xsl:template name="mcommentpage">

   <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
 <title> Marker's Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <link rel="stylesheet" href="stylesheets/letter.css" type="text/css"></link>
     </head>
     <body>
     
        <div class="lettermain">
   <h2>Marker's Comments</h2>
   <!-- Output a link to the main letter for each mcomment. Each mcomment is numbered using xsl:number, so that we can link back to the appropriate mcomment in the main letter. -->
    <xsl:for-each select="//mcomment"> 
    <div class="mcommenttitle">
  <a><xsl:attribute name="href">letter.html#comment<xsl:number  count="mcomment" from="LETTER" level="any"/></xsl:attribute><img alt="back link" src="stylesheets/mcomback.gif"/></a>Comment <xsl:number  count="mcomment" from="LETTER" level="any"/></div>

<div class="mcomment">
<xsl:apply-templates/></div>  
  </xsl:for-each> 
    
         </div>
     </body>
   </html>
 </xsl:template> 
 
 <!-- This creates an anchor for each mcomment inside the main letter. This allows us to link back to each individual mcomment from the mcomment page. -->
<xsl:template match="//mcomment">

<a><xsl:attribute name="href">McommentLetter.html#comment<xsl:number  count="mcomment" from="LETTER" level="any"/></xsl:attribute>
<img alt="Link to Comment" src="stylesheets/mcomment.gif"/></a>
</xsl:template>

<xsl:template match="//comment">

</xsl:template> 
 
 
 <xsl:template match="commentp">
<div>
<xsl:apply-templates/>
</div> 
 </xsl:template>
<!-- 
************************************************************************
* Template: SALUTATION
************************************************************************-->
<xsl:template match="SALUTATN">
	<p>
		<xsl:apply-templates/>
	</p>
</xsl:template> 



<!-- 
************************************************************************
* Template: BODY
************************************************************************-->
<xsl:template match="body">
	
		<div class="letter"><xsl:apply-templates/></div>
	
</xsl:template>

<!-- 
************************************************************************
* Template: SENDER. Adding a class attribute to the div tag makes it easy to style elements with CSS.

************************************************************************-->
<xsl:template match="SENDER">
	<div class="sender">
		<xsl:apply-templates select="ADDRESS"/>
	 <xsl:if test="PHONE"><b>Phone: </b><xsl:value-of select="PHONE"/><br /></xsl:if>
	 <xsl:if test="FAX"><b>Fax: </b><xsl:value-of select="FAX"/><br /></xsl:if>
	 <xsl:if test="EMAIL"><b>Email: </b><xsl:value-of select="EMAIL"/><br /></xsl:if>
	</div>	
</xsl:template>

<!-- 
************************************************************************
* Template: RECIPIENT

************************************************************************-->
<xsl:template match="RECIPNT">
	<div class="recipnt">
	<xsl:value-of select="NAME"/><br />
	<xsl:if test="POSITION"><xsl:value-of select="POSITION"/><br /></xsl:if>
	<xsl:if test="COMPANY"><xsl:value-of select="COMPANY"/><br /></xsl:if>
		<xsl:apply-templates select="ADDRESS"/>
		<!-- We use xsl:if to test if the PHONE, FAX or EMAIL templates are present, so that they output only if the elements are present. -->
	
	</div>	
</xsl:template>


<!-- 
************************************************************************
* Template: DATE
************************************************************************-->
<xsl:template match="HEADING/DATE">
	<div class="date">
		<xsl:apply-templates/>
	</div>
</xsl:template>

<!-- 
************************************************************************
* Template: Address
************************************************************************
-->
<xsl:template match="ADDRESS">
<xsl:for-each select="ADDRLINE"><xsl:apply-templates/><br /></xsl:for-each>
<xsl:value-of select="CITY"/>, <xsl:value-of select="STATE"/><xsl:text> </xsl:text> <xsl:value-of select="CODE"/><br />
<xsl:value-of select="COUNTRY"/><br />


</xsl:template>

<!-- 
************************************************************************
* Template: Phone
************************************************************************
<xsl:template match="HEADING/PHONE">
	<div class="date">
		<xsl:apply-templates/>
	</div>
</xsl:template>

************************************************************************
* Template: Fax
************************************************************************
<xsl:template match="HEADING/FAX">
	<div class="date">
		<xsl:apply-templates/>
	</div>
</xsl:template>

************************************************************************
* Template: Email
************************************************************************
<xsl:template match="HEADING/EMAIL">
	<div class="date">
		<xsl:apply-templates/>
	</div>
</xsl:template>-->

<!-- 
************************************************************************
* Template: FOOTER
************************************************************************-->
<xsl:template match="foot">
	<div class="foot">
		<xsl:apply-templates select="CLOSURE"/><br/>
		<xsl:apply-templates select="NAME"/><br/>
				<xsl:if test="POSITION"><xsl:value-of select="POSITION"/><br /></xsl:if>
			<xsl:if test="COMPANY"><xsl:value-of select="COMPANY"/><br /></xsl:if>

	</div>	
</xsl:template>


<!-- 
************************************************************************
* Template: LINK
************************************************************************-->
<xsl:template match="weblink">
	<a>
<xsl:attribute name="href">
<xsl:value-of select="@href"/>
</xsl:attribute>

	<xsl:if test="contains(@href, 'http://')">

<xsl:attribute name="rel">external</xsl:attribute></xsl:if>
<xsl:apply-templates/>
</a>
</xsl:template>
<!--
************************************************************************
* Template: SUBJECT
************************************************************************-->
<xsl:template match="SUBJECT">
<xsl:if test=".">
<p class="subject">
<b>Subject: </b> <xsl:apply-templates/>
		</p>
</xsl:if>
</xsl:template>

<!--
************************************************************************
* Template: ul, ol
************************************************************************-->
<xsl:template match="ul">

<xsl:element name="ul"> 
<xsl:choose>
	<xsl:when test="@bullet='disc' "><xsl:attribute name="type">disc</xsl:attribute></xsl:when>
	<xsl:when test="@bullet='circle' "><xsl:attribute name="type">circle</xsl:attribute></xsl:when>
	<xsl:when test="@bullet='square' "><xsl:attribute name="type">square</xsl:attribute></xsl:when>
	
</xsl:choose>
<xsl:for-each select="li"><li><xsl:apply-templates/></li></xsl:for-each>  </xsl:element>
</xsl:template>

<xsl:template match="ol">
<ol> 
<xsl:for-each select="li"><li><xsl:apply-templates/></li></xsl:for-each>  </ol>
</xsl:template>
<!--
************************************************************************
* Template: p
************************************************************************-->

<xsl:template match="p">
<p> <xsl:apply-templates/>  </p>
</xsl:template>
<!-- 
************************************************************************
* Template: CITY
************************************************************************
<xsl:template match="CITY">
	<CITYPROVCODE>
		<xsl:apply-templates/>, <xsl:apply-templates select="following-sibling::PROVINCE/text()"/><xsl:text>  </xsl:text><xsl:apply-templates select="following-sibling::CODE/text()"/>
	</CITYPROVCODE>	
</xsl:template>-->

<!-- 
************************************************************************
* Template: b, i -  Bold and Italic
************************************************************************-->
<xsl:template match="b">
<b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="i">
<i><xsl:apply-templates/></i>
</xsl:template>


</xsl:stylesheet>