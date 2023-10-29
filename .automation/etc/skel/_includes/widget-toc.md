{% comment %}
    Generate a "table of contents" from document headings. See:

        https://kramdown.gettalong.org/converter/html.html#toc
        https://stackoverflow.com/a/38419441
        https://jekyllrb.com/docs/configuration/markdown/#kramdown

    Note that this requires Jekyll to be using the Kramdown parser.

    IMPORTANT! Setting `parser_block_html` is necessary if this block
    is to be wrapped in any HTML tags, but doing so basically breaks
    all of our includes!

    Setting `toc_levels` to `2..6` is recommended to exclude `<h1/>`
    tags (for which there should only be one per page/article, and does
    it really make sense to generate a TOC across multiple articles?).

    Note that this widget outputs Markdown, and thus cannot be included
    in HTML pages.
{% endcomment %}

- TOC style seed
{:toc}
