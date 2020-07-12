---
layout: minimal
title: Daily Tip from 100 Consulting Tips of [Art of Gig](https://artofgig.substack.com/)
---

    {% assign num_tips = site.data.artofgig100tips | size %}
    {% assign which_one = "now" | date: "%N" | divided_by: 100 | modulo: num_tips %}
    {% assign theone = site.data.artofgig100tips[which_one].tip %}
    {% assign thewords = site.data.artofgig100tips[which_one].thewords %}


# {{ theone }} #{{ which_one | plus: 1}} 
{: #consultingtip :}

{{ thewords }}
{: #thewords :}
<html>
<button id="nexttipbutton" class="b ba ph3 pv2 submit" onClick="window.location.reload();" style="display:none;">Another One Please</button>

</html>

<script>
document.getElementById("nexttipbutton").style.display="block";
var dailytip_tips;
var dailytip_tips_num;

function dailytip_get_tips_from_data(){
    dailytip_tips={{site.data.artofgig100tips | jsonify}};
    dailytip_tips_num=dailytip_tips.length;
    dailytip_change_tip();
}
function dailytip_change_tip(){
    to_show=Math.floor(Math.random() * dailytip_tips_num);
    to_showplus1=to_show+1;
    document.getElementById("consultingtip").innerHTML=dailytip_tips[to_show].tip+"#"+to_showplus1;
    document.getElementById("thewords").innerHTML=dailytip_tips[to_show].thewords;
}
dailytip_get_tips_from_data();
</script>