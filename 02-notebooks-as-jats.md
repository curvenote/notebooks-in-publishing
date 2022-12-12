---
title: Notebooks as JATS
description: ''
date: 2022-12-09
---

The goal of this article is to recommend community standards for representing Notebooks as [JATS](https://jats.nlm.nih.gov). As discussed in [approach](./approach.md), the notebook can either be the main document of a JATS `article` or as a `sub-article`, which is more appropriate for authors who create figures in different notebooks today, and reference the figures created in those notebooks in the main document.

We propose that all referenced notebooks be represented as:

- A rendering of the notebook, including code and markdown cells, as a JATS `sub-article` of the main the JATS article.
- A copy of the notebook file itself as a Jupyter Notebook file (`.ipynb`) included in the MECA file (referenced via `supplementary-materials`)
- An optional link from the `sub-article` to a deployed version of a notebook (via `self-uri`)
- Optional information about setting up an execution environment for a notebook (via `ext-link` of a specific `type`) in the `sub-article` article metadata.

From within the main `article` within the JATS XML, `xref`s to the `sub-article` or elements within `sub-article` may be used as appropriate.

:::{.callout-note}

This is a very rough `DRAFT`, as we get more authors, we can add stonger language like "we recommend" etc. That may have leaked in already.

:::

## Including Notebooks

(We recommend...) including notebooks as `sub-article`s with the specific `article-type` of `"notebook"`. This choice is made as there are differing requirements on each format. This approach allows the main `article` to follow standard practices of article authoring, e.g. a `"review"` article or similar, with cross-references and inclusion of executable content.

```xml
<sub-article article-type="notebook" id="nb1">
  <front-stub>
    <title-group>
      <article-title>Data access and processing</article-title>
    </title-group>
    <!-- The subarticle should maintain a link to the full, original notebook, e.g. on zenodo -->
    <!-- this allows tools like mybinder, etc to easily integrate -->
    <self-uri xlink:href="https://zenodo.org/record/000001?notebook1.ipynb" content-type="ipynb" assigning-authority="zenodo">Available on Zenodo</self-uri>
    <!-- Additionally, author may include the notebook file in the MECA bundle -->
    <!-- and use a supplementary-material tag to refer to it -->
    <supplementary-material xlink:href="notebooks/source.ipynb" specific-use="document" mimetype="application" mime-subtype="x-ipynb+json" />
  </front-stub>
  <body>
    <!-- Each cell is wrapped in a single boxed-text element, described below -->
    <boxed-text id="nb1-cell-0">...</boxed-text>
    <boxed-text id="nb1-cell-1">...</boxed-text>
    <boxed-text id="nb1-cell-2">...</boxed-text>
  </body>
</sub-article>
```

### Notebook Frontmatter

The inclusion of frontmatter should follow standard practices, using a `front-stub`, at minimum the notebook should include a title for the article. If there are specific authors for each notebook, they can be included here.

There should be a link to other versions of this notebook that are the canonical form. These can be hosted on external repositories (e.g. zenodo, figshare, github) and there can be multiple of these `self-uri` links to where a reader can find the executable, canonical forms of the document.

If the document is stored by the publisher directly, a `supplementary-material` tag can be used, this should point to the same location as it is included in the MECA document.

**TODO:** specific-use: the notebooks can either be the source or an export format (e.g. in using quarto/rmd). Should we list both here, with different content types?

### Indexing Dependencies

From an XML indexing and archiving perspective, it is advantageous to list the requirements to run a computational notebook. These should be captured in such a way that they can give credit to scientific packages, for example, answering questions such as "how many articles used `numpy >= 1.22` this year?".

These should be included in the main `front` of the entire article, not each sub-article (we believe this is a reasonable constraint) that specificies a single computational article for each article, rather than each notebook.

**TODO:** Not sure how to represent this.

Note that the purpose of this is not to replace tools like `requirements.txt`, but to provide information to existing indexing and archiving tools to make use of these data in addition to other ways to keep the computational notebooks fully supported.

### Notebook as the main article

It is possible to use a notebook to author the main article, however, the structure of the JATS in this case is _not_ dictated by the notebook structure, but by the narrative structure.

**TODO** Expand this section/idea. This allows for things like inline execution in the main article, but has different constraints.

The following sections describe notebooks as `sub-article`s, where the structure is designed to recreate the notebook, rather than be constrained by current practices for sections, etc.

## Components of a Notebook

At a high level a notebook consists of (1) text, which is usually a variant of markdown; (2) executable code cells; and (3) a list of outputs from the execution (many of which can be dynamic or interactive). A notebook also requires an execution environment (with loaded dependencies), and at least one language (e.g. Python, R, Julia, etc.) and version of that language, and can depend on external packages and data.

![](images/notebook.png)

> We will consider a computational notebook with three cells: (1) a markdown cell, (2) a cell that does not have any outputs, and (3) a cell that has one or more interactive outputs.

### Text

Text is well specified by JATS, and a rich markdown format (e.g. Quarto, Pandoc, or MyST Markdown) should be used here. This can be parsed into a `boxed-text` element with a `content-type` of `notebook-content`. The notebook cell as [boxed-text](https://jats.nlm.nih.gov/articleauthoring/tag-library/1.3/element/boxed-text.html), can included nested sections, non-executable code, figures, nested boxed text (as callouts or admonitions), or any other narrative content.

```xml
<boxed-text id="nb1-cell-1" content-type="notebook-content">
  <sec id="nb1-working-with-interactive-charts-using-altair" disp-level="2">
    <title>Working with interactive charts using Altair</title>
    <p>
      This chart shows an example of using an interval selection to filter the contents of an
      attached histogram, allowing the user to see the proportion of items in each category within
      the selection. See more in the
      <ext-link ext-link-type="uri" xlink:href="https://altair-viz.github.io/gallery/selection_histogram.html">
        Altair Documentation
      </ext-link>
    </p>
  </sec>
</boxed-text>
```

:::{.callout-caution}

## Note

By wrapping each notebook markdown cell in a `boxed-text` we are choosing to value the structure of the notebook over the structure of section nesting. The result of this choice is the header depth needs to be explicitly preserved (i.e. using `disp-level`, which is not in the Article Authoring tag set but is provided in [Archiving](https://jats.nlm.nih.gov/archiving/tag-library/1.3/attribute/disp-level.html)). Using the `disp-level` the translation to and from markdown/notebook should be lossless.
:::

### Code

Code is also well specified by JATS, however it needs to be optionally associated with the executable output. Executable code should have the `executable` attribute ([docs](https://jats.nlm.nih.gov/articleauthoring/tag-library/1.3/attribute/executable.html)) on a [code](https://jats.nlm.nih.gov/articleauthoring/tag-library/1.3/element/code.html) element. Each element of executable code should also be included in a `boxed-text` element that is described with a `content-type` of `notebook-code`. The notebook cell must include at least a single `code` element that is `executable`, the `language` and `language-version` should be included here.

If the `code` does not have associate outputs, for example when importing libraries, then it can be stand-alone in a `boxed-text` element.

```xml
<boxed-text id="nb1-cell-2" content-type="notebook-code">
  <code language="python" language-version="3.11.1" executable="yes" id="nb1-cell-2-code">
    import altair as alt
    from vega_datasets import data
  </code>
</boxed-text>
```

### Outputs

A code cell in a notebook can have any number of **outputs** (see [nbformat](https://nbformat.readthedocs.io/en/latest/format_description.html#code-cells) as an example), we suggest using a nested `boxed-text` element to capture this list, as they may include text outputs, pre-formatted text (`preformat`), equations (`disp-formula`), graphics and/or interactive media. It is common that notebook outputs provide media in a number of alternative formats (e.g. an interactive HTML figure as well as an image).

```xml
<boxed-text id="nb1-cell-3" content-type="notebook-code">
  <code language="python" language-version="3.11.1" executable="yes" id="nb1-cell-3-code">
    source = data.cars()

    points = alt.Chart(source).mark_point().encode(
      x='Horsepower:Q',
      y='Miles_per_Gallon:Q',
      size='Acceleration',
      color=alt.condition(brush, 'Origin:N', alt.value('lightgray'))
    )

    points
  </code>
  <boxed-text id="nb1-cell-3-output" content-type="notebook-output">
    <alternatives id="nb1-cell-3-output-0">
      <media specific-use="original-format" mimetype="application" mime-subtype="vnd.altair.v1+json" xlink:href="nb1-cell-3-altair.json" />
      <media specific-use="web" mimetype="text" mime-subtype="html" xlink:href="nb1-cell-3.html" />
      <graphic specific-use="print" mimetype="image" mime-subtype="jpeg" xlink:href="nb1-cell-3.jpg"/>
    </alternatives>
  </boxed-text>
</boxed-text>
```

:::{.callout-caution}
**Note**

The “mime-bundle” of `alternatives` is not allowed to be contained in a `boxed-text` element in Article Authoring, but this is allowed in the more permissive tag set of [Archiving](https://jats.nlm.nih.gov/archiving/tag-library/1.3/element/alternatives.html).
:::

### Multiple Outputs

For cells with multiple outputs, these should be included in the single `<boxed-text content-type="notebook-output">` with each element in that list having a specific, numbered ID starting at zero such that it can be referred to independently. In this way downstream viewing application can refer to either the entire cell, the outputs only, or a single output in the list.

```xml
<boxed-text id="nb1-cell-3" content-type="notebook-code">
  <code language="python" language-version="3.11.1" executable="yes" id="nb1-cell-3-code">
    ...
  </code>
  <boxed-text id="nb1-cell-3-output" content-type="notebook-output">
    <output-0 id="nb1-cell-3-output-0" />
    <output-1 id="nb1-cell-3-output-1" />
    <output-2 id="nb1-cell-3-output-2" />
  </boxed-text>
</boxed-text>
```

**Cell Metadata** (TODO)
: It is likely safe to remove cell metadata for archival purposes? There is a [custom-meta-group](https://jats.nlm.nih.gov/archiving/tag-library/1.3/element/custom-meta-group.html) that can contain arbitrary name/value pairs, however, that is aimed to be included only in the [front-stub](https://jats.nlm.nih.gov/archiving/tag-library/1.3/element/front-stub.html) or [article-meta](https://jats.nlm.nih.gov/archiving/tag-library/1.3/element/article-meta.html). For lossless transformation, we could also put this in a nested media or something?

**Raw Cells** (TODO)
: Include these as a `preformat` element inside of a `boxed-text` instead of a `code`?

### Format Outputs for Viewing & Indexing

Many applications allow for rich information to be included in the output areas, including: rendered markdown, $\LaTeX$ equations, figures with captions, or rich interactive visualizations with fallbacks as images, and many more types.

The most appropriate JATS should be used for the output element with a single parent that corresponds to the output. For example, markdown should become a `p` or `sec` with rendered cross-linked information; $\LaTeX$ equations become a `disp-formula`, figures with captions become a `fig` with a nested `caption` and any alternatives for the image/mime-bundle included inside the `fig` element. If there are multiple alternatives in a single element of the output list, it should be wrapped in an `alternatives` as the top level element in the outputs list.

For example, captions can be included in some markup languages. If that is included in the code, e.g. in Quarto:

```python
#| fig-cap: "A line plot on a polar axis"
```

The markup should be stripped from the code input, and put as a `caption` element, with appropriate markup as a `fig` element. This same functionality is being discussed in Jupyter as `Figure` display object, which will be equivalent but in the output metadata.

```xml
<boxed-text id="nb1-cell-4" content-type="notebook-code">
  <code>...</code>
  <boxed-text id="nb1-cell-4-output" content-type="notebook-output">
    <fig id="nb1-cell-4-output-0">
      <caption><title>A line plot on a polar axis</title></caption>
      <graphic specific-use="print" mimetype="image" mime-subtype="jpeg" xlink:href="nb1-cell-4.jpg"/>
    </fig>
  </boxed-text>
</boxed-text>
```

### Referencing an Executable Output

The main `article` can reference executable content pointing to the output where the figure, table, or output came from. In many markup languages is possible using an `embed`, `import`, `include` or `glue` syntax. For computational outputs, there must be `xref` elements included to point to `notebook`, the `notebook-code` and the specific `notebook-output` used. These can either be explicit in the caption or for programatic use these should be specifically tagged with the appropriate `custom-type` for the `xref`.

The same `media` or `graphic` or `table` elements can be used as normal JATS, and point to the same output data.

```xml
<fig id="fig3">
  <label>Figure 3</label>
  <caption>
    <title>Orthogroup clustering analysis</title>
    <p>Lorem ipsum dolor sit amet</p>
    <p>
      <!-- Have a pointer back to the notebook -->
      See methods in <xref ref-type="custom" custom-type="notebook" rid="nb1">Notebook 1</xref>
      <!-- Have a pointer back to the specific cell -->
      from <xref ref-type="custom" custom-type="notebook-code" rid="nb1-cell-3">Cell 4</xref>.
    </p>
  </caption>
  <!-- Support the same mime-bundles as notebooks with fallbacks for print -->
  <alternatives>
    <!-- Specifically point to the notebook output that is used -->
    <xref ref-type="custom" custom-type="notebook-output" rid="nb1-cell-3-output-0" />
    <media specific-use="original-format" mimetype="application" mime-subtype="vnd.plotly.v1+json" xlink:href="nb1-cell-3-plotly.json" />
    <media specific-use="web" mimetype="text" mime-subtype="html" xlink:href="nb1-cell-3.html" />
    <graphic specific-use="print" mimetype="image" mime-subtype="jpeg" xlink:href="nb1-cell-3.jpg" />
  </alternatives>
</fig>
```

For example, in the case of equations, such as a computed `sympy` equation included in the main article body, these need not be explicitly shown as text, but viewing applications can provide rich links back to the containing notebook and output used. For rich viewing applications that integrate computation, this should be enough information to dynamically update the formula based on recomputing the notebook with new data, for example.

```xml
<disp-formula>
  <tex-math id="eqn5"><![CDATA[ ... ]]></tex-math>
  <xref ref-type="custom" custom-type="notebook" rid="nb1" />
  <xref ref-type="custom" custom-type="notebook-code" rid="nb1-cell-4" />
  <xref ref-type="custom" custom-type="notebook-output" rid="nb1-cell-4-output-0" />
</disp-formula>
```

This same approach can be taken for other computed elements, such as tables in a `<table-wrap>`.

### Inline Execution / Variables

**TODO** How to support inline elements like `` `r radius` ``, for example in [knitr](https://quarto.org/docs/computations/execution-options.html#knitr). Jupyter will eventually have this and it would be nice to have the original mapped back in? There is `monospace` or `inline-media`, these could be used in combination with the `xref` approach above if they are explicitly referencing an output, but that isn't how tools like quarto/myst/jupyter are currently designed, so this needs more thought.

This would privide rich references, to specific numbers in an article, and could even be used for inline widgets in articles with alternatives/fallbacks.

For example, `` The study had `r num` participants ``, can we reference a parameter from a notebook, or some other variable in a table?

These could be collected at the top of each article and then referenced, somewhat similar to footnotes?
