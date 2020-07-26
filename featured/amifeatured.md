---
layout: minimal
---

                {% assign featuredone= site.data.featured %} 
                {% assign memb=site.members[featuredone] %}
## {{memb.title}}

follow: @{{memb.twitter}}

sorry, no "special skill" field yet

image: <img src="{{memb.avatar}}">

## vs

 {% include member-card-include.html member=memb %} 
 


