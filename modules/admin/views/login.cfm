<form action="<cfoutput>#event.buildLink(rc.xehLogin)#</cfoutput>" method="post">
	<table width="500" border="0" cellspacing="2" cellpadding="2" align="center">
		<tr>
			<td colspan="2"><h2>Administration Login</h2></td>
		</tr>
		<tr>
			<td colspan="2"><cfoutput>#getPlugin("messagebox").renderit()#</cfoutput></td>
		</tr>
		<tr>
			<td><label for="email">Email:</label></td>
			<td><input type="text" name="email" id="email"></td>
		</tr>
		<tr>
			<td><label for="password">Password:</label></td>
			<td><input type="password" name="password" id="password"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<input type="submit" name="submit" value="Login"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><a href="/">Return to Public Site</a></td>
		</tr>
	</table>
</form>