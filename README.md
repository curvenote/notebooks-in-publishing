---
title: Science Communication with Notebooks
description: ''
date: 2022-12-09
---

[![CC BY 4.0][cc-by-shield]][cc-by]

:::{.callout-caution}

# DRAFT

This is a _rough_ `DRAFT`, aiming to provide recommendations and examples on how to use notebooks in publishing, including how to adapt and improve JATS and other standards. The collaborations for starting these documents came out of [_Notebooks Now!_][notebooks-now] ([Stall _et al._, 2022](https://doi.org/10.5281/zenodo.6981363), see [recording](https://data.agu.org/notebooks-now/2022/11/03/nn-workshop-recordings.html)).

:::

:::{.callout-note}

# Contributors

Current contributors to these documents are:

Rowan Cockett
: **Roles**: Writing – Original Draft Preparation, Software, Visualization
: **Affiliation**: Curvenote Inc
: **GitHub**: @rowanc1
: **ORCID**: https://orcid.org/0000-0002-7859-8394

J.J. Allaire
: **Roles**: Writing – Original Draft Preparation, Software
: **Affiliation**: Posit Software PBC
: **GitHub**: @jjallaire
: **ORCID**: https://orcid.org/0000-0003-0174-9868

Charles Teague
: **Roles**: Writing – Original Draft Preparation, Software
: **Affiliation**: Posit Software PBC
: **GitHub**: @dragonstyle
: **ORCID**: https://orcid.org/0000-0001-8715-9476

Jeffrey Beck
: **Roles**: Writing – Review & Editing, Conceptualization
: **Affiliation**: National Center for Biotechnology Information, National Library of Medicine, National Institutes of Health, Bethesda, MD 20894, USA.
: **GitHub**: @jeffbeckncbi
: **ORCID**: https://orcid.org/0000-0002-1798-9797

Christopher Erdmann
: **Roles**: Writing – Original Draft Preparation, Conceptualization
: **Affiliation**: Michael J. Fox Foundation
: **GitHub**: @libcce
: **ORCID**: https://orcid.org/0000-0003-2554-180X

:::

At [_Notebooks Now!_][notebooks-now], we looked at the academic publishing workflows around notebooks as a number of steps: (1) pre-submission, (2) submission & metadata, (3) editorial & peer review, and (4) production & post production. Each step of this workflow and how they fit together may be required to change or adapt when considering computational content in notebooks as a core publication artifact.

![](images/workflow.png)

To archive, host, and disseminate scholarly articles publishers typeset author submissions. This process not only creates PDFs and websites, it also adds structured information around citations, cross-references, and other important attribution metadata (ORCIDs, funding identifiers, RoRs, and other PIDs) which are distributed to other participants in the ecosystem (e.g. PubMed, CrossRef, indexers, archivers, etc.). In the context of open access, it is now common[^openaccessjats] that this Version or Record (VoR) includes the full text of the article as well as figures and tables; it is no longer just the abstract, authors, and references. The full text is most often stored in an XML format which can be used to create all other views of this content (PDF, HTML). The structure of this XML varies between publisher, with the most used open standard being JATS ([Journal Article Tag Suite](https://jats.nlm.nih.gov/)), a [NISO standard](https://www.niso.org/standards-committees/jats).

[^openaccessjats]: There are currently 5.8 million works with full-text XML available through CrossRef, for example. See [CrossRef’s API](https://api.crossref.org/works?filter=full-text.type:application/xml,full-text.application:text-mining&facet=publisher-name:*&rows=0).

When considering how to include notebooks in publishing, identifying how to include the notebook content in the VoR will unlock all current downstream providers, and allows the use of notebooks in publishing to be broadly adopted. Here we will discuss the constraints of JATS, suggest missing components, and recommend community standards to support notebooks in the VoR. These are designed to support various use cases of browsing, replication, and distribution of these articles as executable documents. We also consider how these processes fit into author-driven workflows to allow for continuous updates, feedback, and iterations throughout the process of creating this structured data.

## Contents

- [Approach](./docs/01-approach.md)
- [Notebooks as JATS](./docs/02-notebooks-as-jats.md)
- [MECA Notebooks](./docs/03-meca-notebooks.md)
- [Working Notes](./docs/04-notes.md)

---

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
[notebooks-now]: https://data.agu.org/notebooks-now/
