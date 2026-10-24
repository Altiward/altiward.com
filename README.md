# altiward.com

The source of [altiward.com](https://altiward.com/), a static site served by GitHub Pages.

Plain HTML and one stylesheet. There's no build step: the files in this repository are what's served.

## Content

The site is the front door to Altiward on GitHub.

After GitHub Pages publishes a change, the IndexNow workflow tells Bing and the other search engines that use IndexNow which pages changed. They check each submission against the key file at the root, `a02685625c482622e90b3b99e12b4193.txt`, so keep it. Run the workflow by hand to submit every page in the sitemap.

## Licence

The site is licensed under the [Apache License 2.0](LICENSE).

The Altiward name and logo are trademarks and aren't licensed: Apache 2.0 grants no rights to use them, apart from describing where the site came from.

The Inter and JetBrains Mono fonts in `fonts/` are licensed separately under the SIL Open Font License 1.1; see [fonts/OFL-inter.txt](fonts/OFL-inter.txt) and [fonts/OFL-jetbrains-mono.txt](fonts/OFL-jetbrains-mono.txt).

The free Unexpected admins check in `tools/unexpected-admins.zsh` stays MIT licensed, as noted in the script.
