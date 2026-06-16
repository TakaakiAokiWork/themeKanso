# themeKanso

A simple, clean ggplot2 theme. "Kanso" (簡素) means *simplicity*.
`theme_kanso()` extends `theme_minimal()` with reduced margins and grid lines
for an uncluttered look.

## Installation

```r
# from GitHub
remotes::install_github("<user>/themeKanso")

# from a local source tree
remotes::install_local("themeKanso")
```

## Usage

```r
library(ggplot2)
library(themeKanso)

ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
  geom_point() +
  labs(title = "themeKanso", subtitle = "Kanso") +
  theme_kanso()
```

`theme_kanso()` takes a base font size and family.

```r
theme_kanso(base_size = 14, base_family = "")
```

## Gallery

| | |
|---|---|
| ![Scatter](man/figures/scatter.png) | ![Histogram](man/figures/histogram.png) |
| ![Line](man/figures/line.png) | ![Heatmap](man/figures/heatmap.png) |
| ![Bar](man/figures/bar.png) | ![Boxplot](man/figures/boxplot.png) |
| ![Facet](man/figures/facet.png) | |

The gallery uses standard datasets (`iris`, `diamonds`, `txhousing`,
`faithfuld`, `mpg`), the AAAS palette from [ggsci](https://nanx.me/ggsci/) for
discrete scales, and viridis for the continuous one. Regenerate with:

```r
Rscript data-raw/make_readme_figures.R   # requires ggsci, patchwork
```

### Multi-panel layout

Three panels side by side at A4 text width (16 cm) with
[patchwork](https://patchwork.data-imaginist.com/). Panel tags from
`plot_annotation(tag_levels = "A")` are rendered bold and top-left by the theme.

![Patchwork row](man/figures/patchwork_row.png)

## License

MIT License
