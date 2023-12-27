# Yak Collective Projects

Yak Collective projects are collaborations and explorations from the community.

{% assign projects = site.pages | where: "layout", "page-project"
                                | where_exp: "project", "project.date <= site.time or site.future == true"
                                | sort: "date"
                                | reverse %}

{% for project in projects %}
    {% assign project_id = project.name | replace: ".md", "" | replace: ".html", "" %}
    {% include widget-project-box.html project=project_id %}
{% endfor %}
