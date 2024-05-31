<?xml version="1.0" encoding="UTF-8"?>
<?xml-md5 bd00a70108315b6d6647067ab5902b3c?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="html" version="1.0" media-type="text/html" encoding="UTF-8"/>
	<xsl:template match="/root">
	<html>
		<head>
			<script language="javascript" type="text/javascript" src="../jplot/jquery-3.1.1.min.js"></script>
			<script language="javascript" type="text/javascript" src="../jplot/jquery.jqplot.min.js"></script>
			<script language="javascript" type="text/javascript" src="../jplot/jqplot.cursor.js"></script>
			<script language="javascript" type="text/javascript" src="../jplot/jqplot.canvasTextRenderer.js"></script>
			<script language="javascript" type="text/javascript" src="../jplot/jqplot.canvasAxisLabelRenderer.js"></script>
			<link rel="stylesheet" type="text/css" href="../jplot/jquery.jqplot.css"/>
		
			<style type="text/css">
			.body {padding: 5px;margin: 0px;vertical-align: top}
			.t1 { border-spacing:0;	width : 100%; vertical-align: top;}
			.header {white-space:nowrap; border-spacing:0; background-color:#ddeeee;}
			.header td {text-align : center; font : bold 20px Arial; color : gray; border : 1px solid gray; height : 20pt}
			
			.test_header {text-align : center; height : 30pt ;white-space:nowrap;font : bold 20px Arial;	color :  black;}
			.test{text-align : left;	font : 14px Arial;	color :  black;}
			.warning{font-size:1.2em;margin:0;color:#CC0000;} 
			.normal{text-align : left;font-size:1.2em;margin:0;color:#0088AA;} 
			</style>
			<script language="javascript" type="text/javascript">
			<![CDATA[
			function paint(divid, file, name, col_x, cols_y)
			{
				$.get(file, function( data ) 
				{
					var allTextLines = data.split(/\r\n|\n/);
					var labels=new Array;
					var plot_data=new Array;
					
					var cols = allTextLines[0].split(';');
					for (col in cols_y)
						labels.push(cols[cols_y[col]]);
						
					for (row=1;row<allTextLines.length;row++)
					{
						var cols = allTextLines[row].split(';');
						for (col in cols_y)	
						{
							if (plot_data.length<=col) plot_data.push(new Array);
							plot_data[parseInt(col)].push([parseFloat(cols[col_x]),parseFloat(cols[cols_y[col]])]);
						//	alert(col+":"+cols[col_x]+","+cols_y[col]+","+cols[cols_y[col]]);
						}
					}
					$.jqplot(divid,  plot_data, 
					{
						title:name,
						legend: {
							show:true,
							labels:labels
						},
						cursor:{
							show:true,
							zoom:true
						},
						seriesDefaults: {
							showMarker: false,
							pointLabels: { show:true }
						}
					});
				},'text');
			}
			]]>
			$(function() {
				$.jqplot.config.enablePlugins = true;
				<xsl:for-each select="//*/plot">
				paint('<xsl:value-of select="@id"/>','<xsl:value-of select="@source"/>','<xsl:value-of select="@title"/>',<xsl:value-of select="@axis_x"/>,<xsl:value-of select="@series"/>);
				</xsl:for-each>
			});

			</script>
		</head>
		
		<body class="body" >
			<table class="t1" >
				<tr class="header" >
					<td >
						<xsl:value-of select="@title"/> от <xsl:value-of select="@date"/>
					</td>
				</tr>
				<tr height="20"/>
				<xsl:for-each select="test">
					<tr class="test_header">
						<td>
							<xsl:value-of select="@name"/>
						</td>
					</tr>
					<tr class="test">
						<td width="100%">
							<table height="100%">
								<xsl:for-each select="row">
									<tr>
										<td align="left" style="background-color:#eeeeee">
											<xsl:value-of select="@name"/>
										</td>
										<td align="left" style="background-color:#dddddd">
											<xsl:value-of select="text()"/>
										</td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
					<xsl:for-each select="plot">
						<tr>
							<td>
								<div id="{@id}" style="height:200px;width:100%;"/>
							</td>
						</tr>
					</xsl:for-each>
					<tr height="20"/>
				</xsl:for-each>
			</table>
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
