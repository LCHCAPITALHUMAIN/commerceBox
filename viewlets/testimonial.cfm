<cfset runEvent(event='viewlet.prepareRandomTestimonial',private=true)>
<div class="outerbox">
    <div class="boxtab"><h3>Testimonials</h3></div>
    <div class="innerbox">
      <blockquote>
        <p><cfoutput>#rc.randomTestimonial.getContent()# &mdash;<cite>#rc.randomTestimonial.getAuthor()#</cite></cfoutput></p>
      </blockquote>
    </div>
</div>