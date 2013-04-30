<div class="outerbox" style="float:left">
	<div class="boxtab"><h2>Contact <cfoutput>#getSetting("siteName")#</cfoutput></h2></div>
	 <div class="innerbox" style="float:left">
		<cfoutput>#getPlugin("messagebox").renderit()#</cfoutput>
		<p style="margin-bottom:10px;">Thank you for your interest in  <cfoutput>#getSetting("siteName")#</cfoutput>. Please use the form below or our address and phone number to contact <cfoutput>#getSetting("siteName")#</cfoutput> with your questions and feedback.</p>
		<div style="float:left; padding:5px; border:1px solid #ccc; width:400px; height:260px;">
		<table cellspacing="0" class="custom-form">
			<tr>
				<td>
				<form action="<cfoutput>#event.buildLink("contact/doContact")#</cfoutput>" method="post" name="feedback" id="feedback">
					<table cellspacing="0">
						<tr>
							<td><label for="fullName">Full Name:</label></td>
						</tr>
						<tr>
							<td><input name="fullName" id="fullName" class="text required" type="text" size="30" /></td>
						</tr>
						<tr>
							<td><label for="email">Email:</label></td>
						</tr>
						<tr>
							<td><input name="email" id="email" class="text required validate-email" type="text" size="30" /></td>
						</tr>
						<tr>
							<td><label for="message">Message:</label></td>
						</tr>
						<tr>
							<td><textarea cols="45" rows="5" name="message" id="message" class="required"></textarea></td>
						</tr>
						<tr>
							<td><input type="hidden" name="password" value="" />
								<input name="send" type="submit" value="Send Email" /></td>
						</tr>
					</table>
				</form></td>
			</tr>
		</table>
		</div>
		<div style="float:right; border:1px solid #ccc; width:390px; height:260px; padding:5px">
			<h4 style="margin:0"><cfoutput>#getSetting("siteName")#</cfoutput></h4>
			<p></p>
		</div>
		<script type="text/javascript">
			var valid = new Validation('feedback', {immediate : true});
		</script>
	</div>
</div>