{% comment %}
    Generate a list of posts, organized by month and year, formatted
    after Wikipedia's reference style. Expects the following parameters
    to be passed in:

        `init_header_level`
        The initial header level to use. If "2" is passed in, then `h2`
        tags will be used for years and `h3` tags for months, etc.
        Defaults to "2", as that's what most pages will use. Values
        larger than "5" are treated as "5", since `<h7/>` tags don't
        exist in HTML.

        `show_months`
        If `true`, then show month headers in addition to years.

        `show_date`
        If `true`, then show post date.

        `show_author`
        If `true`, then show post author.

        `author`
        Filter posts by author ID (`rao-venkatesh`, etc.). Note that
        if this is non-nil/false, then posts without an author
        specified in their front matter will not be displayed.

        `category`
        Filter posts by category.

    Note that this widget outputs Markdown (in order to allow for
    compatability with Kramdown's "table of contents" functionality),
    and thus cannot be included in HTML pages.
{% endcomment %}

{% comment %}
    Figure out our header prefixes.
{% endcomment %}
{% assign base_header_level = include.init_header_level | default: 2 %}
{% if base_header_level == 1 %}
    {% assign header_year = "# " %}
    {% assign header_month = "## " %}
{% elsif base_header_level == 2 %}
    {% assign header_year = "## " %}
    {% assign header_month = "### " %}
{% elsif base_header_level == 3 %}
    {% assign header_year = "### " %}
    {% assign header_month = "#### " %}
{% elsif base_header_level == 4 %}
    {% assign header_year = "#### " %}
    {% assign header_month = "##### " %}
{% else %}
    {% assign header_year = "##### " %}
    {% assign header_month = "###### " %}
{% endif %}

{% comment %}
    Capture one and two newlines. We'll need them later.
{% endcomment %}
{% capture one_newline %}
{% endcapture %}
{% capture two_newlines %}

{% endcapture %}

{% comment %}
    Filter `site.posts` by `category`, `author,` and earliest project date.
{% endcomment %}
{% if include.category %}
    {% assign filtered_posts = site.categories[include.category] %}
    {% assign id_prefix = include.category | append: "-" %}
{% else %}
    {% assign filtered_posts = site.posts %}
    {% assign id_prefix = "post-" %}
{% endif %}
{% if include.author %}
    {% assign filtered_posts = filtered_posts | where: "author", include.author %}
{% endif %}
{% assign yak_start = site.time %}
{% for page in site.pages %}
    {% if page.date and page.layout == "page-project" %}
        {% if page.date < yak_start %}
            {% assign yak_start = page.date %}
        {% endif %}
    {% endif %}
{% endfor %}
{% assign filtered_posts = filtered_posts | where_exp: "post", "post.date >= yak_start"
                                          | sort: "url"
                                          | reverse
                                          | sort: "date"
                                          | reverse %}

{% comment %}
    Loop through the `filtered_posts` array. Output top-level headings
    for month and year, changing these as post month and year changes.
    Only output actual post content if the post author is listed on the
    `/members/` page (so as not to output posts from "pending" members).

    Adapted from: https://stackoverflow.com/a/19104574
{% endcomment %}
{% assign post_list = "" %}
{% for post in filtered_posts %}
    {% assign this_year = post.date | date: "%Y" %}
    {% assign this_month = post.date | date: "%B" %}
    {% unless forloop.last %}
        {% assign next_post_index = forloop.index0 | plus: 1 %}
        {% assign next_post = filtered_posts[next_post_index] %}
        {% assign next_year = next_post.date | date: "%Y" %}
        {% assign next_month = next_post.date | date: "%B" %}
    {% else %}
        {% assign next_year = this_year %}
        {% assign next_month = this_month %}
    {% endunless %}

    {% if forloop.first %}
        {% assign post_list = post_list | append: header_year
                                        | append: this_year
                                        | append: one_newline %}
        {% assign post_list = post_list | append: "{: #"
                                        | append: id_prefix
                                        | append: this_year
                                        | append: "}"
                                        | append: two_newlines%}
        {% if include.show_months %}
            {% assign post_list = post_list | append: header_month
                                            | append: this_month
                                            | append: one_newline %}
            {% assign post_list = post_list | append: "{: #"
                                            | append: id_prefix
                                            | append: this_year
                                            | append: "-"
                                            | append: this_month
                                            | append: "}"
                                            | append: two_newlines %}
        {% endif %}
    {% endif %}

    {% comment %}
        Post authors are stored "symbolically". We use the `name`
        attribute to look up the author's name (a.k.a. `title`), and
        `date` (the member "join date") from the `site.pages` array.
    {% endcomment %}
    {% assign author_url = "/members/" | append: post.author | append: "/" %}
    {% assign author = site.pages | find: "url", author_url %}

    {% comment %}
        We show posts when `show_author` is falsy OR when it's after the
        join date of the member who made the post. The reason for the
        "or" here is that is `show_author` is falsy, then we're going to
        implicitly assume that we're on a page with a single post
        author, and we don't want to risk displaying an empty list of
        posts if they haven't yet "officially" joined.

        Note that we use HTML rather than markdown here, as otherwise
        there's a weird bug where the time specification is parsed as if
        it were on a seperate line.
    {% endcomment %}
    {% assign show_post = true %}
    {% if include.show_author and author.date > site.time and site.future != true %}
        {% assign show_post = false %}
    {% endif %}
    {% if show_post %}
        {% if include.show_date %}
            {% assign post_list = post_list | append: '<div><time class="courier b">' %}
            {% assign formatted_date = post.date | date: "%d %b" %}
            {% assign post_list = post_list | append: formatted_date %}
            {% assign post_list = post_list | append: "</time>" %}
        {% endif %}
        {% if include.show_author %}
            {% if include.show_date %}
                {% assign post_list = post_list | append: ' ' %}
            {% endif %}
            {% assign post_list = post_list | append: '<a href="' %}
            {% assign post_list = post_list | append: author.url %}
            {% assign post_list = post_list | append: '">' %}
            {% assign post_list = post_list | append: author.title %}
            {% assign post_list = post_list | append: "</a>" %}
        {% endif %}
        {% if include.show_author or include.show_date %}
            {% assign post_list = post_list | append: ': ' %}
        {% endif %}
        {% assign post_list = post_list | append: '<em><a href="' %}
        {% if post.original_link %}
            {% assign post_list = post_list | append: post.original_link %}
        {% else %}
            {% assign post_list = post_list | append: post.url %}
        {% endif %}
        {% assign post_list = post_list | append: '">' %}
        {% assign post_list = post_list | append: post.title | rstrip %}
        {% assign post_list = post_list | append: "</a></em></div>" %}
        {% assign post_list = post_list | append: one_newline %}
    {% endif %}

    {% if forloop.last %}
        {% assign post_list = post_list | append: one_newline %}
    {% else %}
        {% if this_year != next_year %}
            {% assign post_list = post_list | append: one_newline %}
            {% assign post_list = post_list | append: header_year
                                            | append: next_year
                                            | append: one_newline %}
            {% assign post_list = post_list | append: "{: #"
                                            | append: id_prefix
                                            | append: next_year
                                            | append: "}"
                                            | append: two_newlines %}
            {% if include.show_months %}
                {% assign post_list = post_list | append: header_month
                                                | append: next_month
                                                | append: one_newline %}
                {% assign post_list = post_list | append: "{: #"
                                                | append: id_prefix
                                                | append: next_year
                                                | append: "-"
                                                | append: next_month
                                                | append: "}"
                                                | append: two_newlines %}
            {% endif %}
        {% else %}
            {% if include.show_months and this_month != next_month %}
                {% assign post_list = post_list | append: one_newline %}
                {% assign post_list = post_list | append: header_month
                                                | append: next_month
                                                | append: one_newline %}
                {% assign post_list = post_list | append: "{: #"
                                                | append: id_prefix
                                                | append: next_year
                                                | append: "-"
                                                | append: next_month
                                                | append: "}"
                                                | append: two_newlines %}
            {% endif %}
        {% endif %}
    {% endif %}
{% endfor %}

{% comment %}
    Output `post_list` markdown.
{% endcomment %}
{{ post_list }}
