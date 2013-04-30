<cfoutput>#renderView("article/sidebar")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab"><h2><cfoutput>#rc.title#</cfoutput></h2></div>
		<div class="innerbox">
			<div class="infobox"> 
				<cfoutput>
				<form name="sort" action="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/#event.getValue("id","")#" id="sort" method="post">
					<label for="field">Sort articles by:</label>
					<select name="sortBy" onChange="this.form.submit();">
						<option selected="selected" value="">Select</option>
						<option value="id">Latest</option>
						<option value="title">Title</option>
						<option value="views">Popularity</option>
					</select>
					<noscript><input type="submit" name="submit" value="sort" /></noscript>
				</form>
				</cfoutput>
			</div>
			<ul>
				<cfoutput query="rc.qarticles">
					<li><a href="#getSetting("sesBaseURL")#/#rc.xehDetails#/#rc.qarticles.id#" title="#rc.qarticles.title#">#rc.qarticles.title#</a> (views #rc.qarticles.views#)</li>
				</cfoutput>
			</ul>
		</div>
	</div>
</div>