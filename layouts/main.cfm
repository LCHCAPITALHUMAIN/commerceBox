<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<html lang="en">
<cfoutput>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>#Event.getValue('title', "#getController().getSetting("siteName")#, #getController().getSetting("tagLine")#")#</title>
		<meta name="description" content="#Event.getValue("description","#getController().getSetting("tagline")#")#" />
		<meta name="keywords" content="#Event.getValue("keywords","#getController().getSetting("keywords")#")#" />
		<meta name="revisit-after" content="#Event.getValue("revisit","15 days")#" />
		<meta name="google-site-verification" content="" />
		<meta name="y_key" content="3d9fa0d8d958bf41" /> 
		<meta name="copyright" content="#getController().getSetting("siteName")# Copyright #year(Now())#. All rights reserved." />
		<link href="/favicon.ico" rel="shortcut icon" type="image/ico" />
		<cfinclude template="/includes/controllers/styles.cfm" />
		<link type="text/css" rel="stylesheet" href="css/styles.css" />
		<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
		<!--[if lt IE 9]>
			<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
			<script>window.html5 || document.write('<script src="js/lib/html5shiv.js"><\/script>')</script>
		<![endif]-->
	</head>
	
	<body id="home">
		<div id="container-site">
		
			<div id="advert-header" class="row-fluid text-center">
				<span>Interested in advertising on stand4secondammendment.com</span>
				<a href=""><img src="img/banner-add.jpg" alt="advertisment" /></a>
			</div>
				
			<div id="site-header">
			
				<div id="nav-utility" class="navbar span4">
  				<div class="navbar-inner">
						<div class="container">
								<ul class="nav nav-pills">
									<li><a href="##">SIGN IN</a></li>
									<li><a href="##">JOIN</a></li>
									<li><a href="##">SUBSCRIBE</a></li>
								</ul>
						</div><!-- end container -->
					</div><!-- end navbar-inner -->
				</div><!-- end navbar -->
				
				<a href=""><img src="img/logo.png" alt="Stand4secondAmmendment" /></a>
				
				<div id="nav-site" class="navbar">
  				<div class="navbar-inner">
						<div class="container">
								<ul class="nav nav-pills">
									<li class="active"><a href="##">Home</a></li>
									<li><a href="##">Take Action</a></li>
									<li><a href="##">News/Facts</a></li>
									<li><a href="##">Calendar</a></li>
									<li><a href="##">Our Mission</a></li>
									<li><a href="##">Contact Us</a></li>
								</ul>
						</div><!-- end container -->
					</div><!-- end navbar-inner -->
				</div><!-- end navbar -->
				
				<br class="clearfix" />
				
      </div><!-- end page-header -->
			
			<div id="container-content">
			
				<ul class="breadcrumb">
					<li class="active"><a href="##">Home</a> <span class="divider">/</span></li>
				</ul>
				
				#renderView()#
			</div><!-- end container-content -->
			
			<div id="footer">
        <p class="copyright">Copyright &copy; #year(Now())# #getController().getSetting("siteName")#. All Rights Reserved.</p>
      </div>
			
		</div><!-- end container-site -->
	</body>
	
	<!-- load in javascript -->
	<script src="//code.jquery.com/jquery.js"></script>
	<script>window.jQuery || document.write('<script src="js/lib/jquery-1.9.1.min.js"><\/script>')</script>
	<script src="js/lib/bootstrap.min.js"></script>
</cfoutput>
</html>
