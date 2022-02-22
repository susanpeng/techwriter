<?xml version='1.0' standalone='no'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
 >

<xsl:output name="resume-format" method="xhtml" indent="yes"
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
	    <xsl:result-document href="../Output/letterandresume/McommentResume.html" format="resume-format">
  <xsl:call-template name="mcommentpage"/>
  </xsl:result-document>
    </xsl:if>
    <!-- Output an HTML page called letter.html. -->
 <xsl:result-document href="../Output/letterandresume/resume.html" format="resume-format">
	<html xmlns="http://www.w3.org/1999/xhtml">
      <head><title>Resume</title>
      <link rel="stylesheet"  type="text/css" href="stylesheets/letter.css"/></head>
      <body>
          <div class="resumemain">
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
 <title> <xsl:value-of select="helpmanual/front/title"/> Marker's Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <link rel="stylesheet" href="stylesheets/letter.css" type="text/css"></link>
     </head>
     <body>
     
        <div class="resumemain">
   <h2>Marker's Comments</h2>
   <!-- Output a link to the main letter for each mcomment. Each mcomment is numbered using xsl:number, so that we can link back to the appropriate mcomment in the main letter. -->
    <xsl:for-each select="//mcomment"> 
    <div class="mcommenttitle">
  <a><xsl:attribute name="href">resume.html#comment<xsl:number  count="mcomment" from="LETTER" level="any"/></xsl:attribute><img alt="back link" src="stylesheets/mcomback.gif"/></a>Comment <xsl:number  count="mcomment" from="LETTER" level="any"/></div>

<div class="mcomment">
<xsl:apply-templates/></div>  
  </xsl:for-each> 
    
         </div>
     </body>
   </html>
 </xsl:template> 
 
 <!-- This creates an anchor for each mcomment inside the main letter. This allows us to link back to each individual mcomment from the mcomment page. -->
<xsl:template match="//mcomment">

<a><xsl:attribute name="href">McommentResume.html#comment<xsl:number  count="mcomment" from="RESUME" level="any"/></xsl:attribute>
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
* Template: 
************************************************************************-->
<xsl:template match="RESUME">
<xsl:apply-templates select="PERSDATA"/>
<hr width="758px" />
<table width="775px" cellpadding="5">
<col id="state" width="250px"/>
<col id="content" width="550px"/>
	<tbody>
	
		<tr >
			<td class="heading" valign="top">Objective</td>
			<td><xsl:apply-templates select="OBJECTV"/></td>
		</tr>
		
			<tr>
		<td class="heading" valign="top">Skills</td>
			<td><xsl:apply-templates select="SKILLS"/></td>
		</tr>
		

		
			<tr>
		<td class="heading" valign="top">Work Experience</td>
			<td><xsl:for-each select="WORKEXP/JOB">
<div 	class="postscd"><b><xsl:apply-templates select="EMPLOYER"/></b><xsl:text> </xsl:text><xsl:apply-templates select="LOCATION"/><br />
<xsl:apply-templates select="POSITION"/><xsl:text> </xsl:text> <xsl:apply-templates select="DATE"/>
<xsl:apply-templates select="ul"/></div></xsl:for-each></td>
			</tr>
	 
	 <tr>
	  <td class="heading"  valign="top">Education</td>
	  <td><xsl:for-each select="EDUCATN/POSTSECD">
	   <div 	class="postscd"><b><xsl:apply-templates select="INSTNAME"/></b><xsl:text> </xsl:text><xsl:apply-templates select="LOCATION"/><br />
	    <xsl:apply-templates select="PROGRAM"/><xsl:text> </xsl:text> <xsl:apply-templates select="DATE"/>
	    <xsl:if test="INFO"><br /><xsl:apply-templates select="INFO"/></xsl:if>
	   </div>		
	  </xsl:for-each>
	  </td>
	 </tr>
	 
	
		<xsl:for-each select="SECTION">
				<tr>
		<td class="heading" valign="top"><xsl:value-of select="TITLE"/></td>
			<td><xsl:apply-templates select="p | ul"/></td>
		</tr>
		</xsl:for-each>
	 <xsl:if test="INTRESTS">
	  <tr>
	   <td class="heading" valign="top">Interests</td>
	   <td><xsl:apply-templates select="INTRESTS"/></td>
	  </tr>
	 </xsl:if>
<xsl:if test="REFS">
				<tr>
			<td class="heading"  valign="top">References</td>
				 <td><xsl:if test="REFS/p"><xsl:apply-templates select="REFS/p"/></xsl:if>
			 <xsl:for-each select="REFS/REFRNCE">
<div 	class="postscd"><b><xsl:apply-templates select="NAME"/></b><xsl:text>, </xsl:text><xsl:apply-templates select="POSITION"/><br />
<xsl:apply-templates select="PHONE"/><xsl:text> </xsl:text> <xsl:apply-templates select="EMAIL"/>
</div>		
</xsl:for-each>		
			</td>
		</tr>
		</xsl:if>
	</tbody>
</table>
 <hr width="758px" /> 
</xsl:template> 


<!-- 
************************************************************************
* Template: RECIPIENT

************************************************************************-->
<xsl:template match="PERSDATA">
	<div class="persdata">
	<span class="resumename"><xsl:value-of select="NAME"/></span><br />
	<xsl:apply-templates select="EMAIL"/><xsl:text> </xsl:text><xsl:if test="PHONE"><xsl:value-of select="PHONE"/></xsl:if><br />
	<xsl:apply-templates select="ADDRESS"/>
		
	</div>	
</xsl:template>

<!-- 
************************************************************************
* Template: 
************************************************************************-->
<xsl:template match="PERSDATA/ADDRESS">
<xsl:for-each select="ADDRLINE"><xsl:apply-templates/>, </xsl:for-each>
<xsl:value-of select="CITY"/>, <xsl:value-of select="STATE"/><xsl:text> </xsl:text> <xsl:value-of select="CODE"/><xsl:text> </xsl:text><xsl:if test="COUNTRY"><xsl:value-of select="COUNTRY"/><br /></xsl:if><br />	
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
* Template: ul
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

<!--
************************************************************************
* Template: p
************************************************************************-->

<xsl:template match="p">
<xsl:choose>
	<xsl:when test="parent::OBJECTV and position()=1"><p class="firstp"> <xsl:apply-templates/>  </p></xsl:when>
	<xsl:when test="parent::SKILLS and position()=1"><p class="firstp"> <xsl:apply-templates/>  </p></xsl:when>
	<xsl:when test="parent::INTRESTS and position()=1"><p class="firstp"> <xsl:apply-templates/>  </p></xsl:when>
	<xsl:when test="parent::SECTION and position()=1"><p class="firstp"> <xsl:apply-templates/>  </p></xsl:when>
	<xsl:when test="parent::REFS and position()=1"><p class="firstp"> <xsl:apply-templates/>  </p></xsl:when>
	<xsl:otherwise><p> <xsl:apply-templates/>  </p></xsl:otherwise>
	
</xsl:choose>


</xsl:template>


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
