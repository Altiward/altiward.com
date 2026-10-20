# Contributing to altiward.com

The site is plain HTML and CSS, published directly from the repository root. Each page's
folder matches its public URL; keep existing URLs when reorganising source material.

| Location | Content |
| --- | --- |
| `index.html` | The front door: the three projects and which one you need |
| `altiward/`, `how-it-works/` | Altiward's product page, and how its checks behave |
| `forwarder/`, `detections/` | The companion projects: altiward-forwarder and altiward-siem |
| `guides/` | Task-oriented guides and comparisons |
| `laps/`, `dspt-caf/` | Topic-specific landing pages |
| `security/`, `.well-known/security.txt` | Security reporting information |
| `images/`, `fonts/`, root icons and `site.css` | Shared site assets |
| `tools/` | Downloadable tools referenced by guides |

Preview from the repository root with `python3 -m http.server 8000`, then open
`http://localhost:8000`. Review the page on a narrow screen and check its links and
anchors. Headers and footers are shared markup copied across pages: update every copy
when changing navigation, preserving the active page's `aria-current` attribute.

Keep installation details in the application's docs and link to their canonical
locations. Brand sources live in the application's `assets/brand/`; its
`scripts/brand/export.sh website <path-to-this-checkout>` refreshes the SVG mark.
`og.png` is the brand's SocialCard; refresh it from the application's checkout with
`swift scripts/brand/render-social.swift ../altiward.com/og.png website`. The other raster
assets (`mark.png`, `apple-touch-icon.png`, `favicon.ico`) and the console screenshots in
`images/` are maintained here. The screenshots are real captures of the console with example
data, never drawings: `console-<view>-light.png` and `-dark.png`, at a 1440 by 900 viewport and
device scale 2 (the revocation shots are crops of the detail panel and dialog). Pages show them
with `<picture>`, the dark one under `prefers-color-scheme: dark`, with width, height and alt
text, and every caption says "Example data".

Every page follows the system setting: light by default, dark when the reader asks for it.
Colours come only from the tokens at the top of `site.css`, which follow the Altiward design
system (brand v4, Mono): greys and ink, with colour only for state. The pages run no script
(`script-src 'none'`), so the Products menu is a `<details>` element. The session strip on
the Altiward product page and example cards on How it works are drawn in HTML and CSS.

Follow the organisation's contribution guide and sign off commits with `git commit -s`.
For security reports, use the contact information in `security/`.

Before launch, check every page at desktop and phone widths, including the Products menu,
scrolling comparison tables, screenshot viewers and the 404 page. Keep page titles,
descriptions, structured data, the social preview and `sitemap.xml` in step with content changes.

Retain the tracked `.nojekyll` marker when publishing this static site from a branch.
Include `.well-known/security.txt` in the deployed files and verify its canonical URL
returns HTTP 200. A custom 404 page at that URL does not count. If the deployment later
uses a custom artifact workflow, make sure packaging retains this required hidden directory.

While the repositories are private, validate GitHub file paths and README anchors against
the sibling checkouts. Anonymous GitHub 404s are expected at this stage. Public launch
depends on those repositories and their linked release assets being accessible without
signing in. The Sentinel deployment button also needs the public `altiward-siem` tag
`v0.1.0` and its `sentinel/azuredeploy.json`. Recheck these links in a signed-out browser
after publication, along with the live site's HTTPS, custom 404 and security contact.
