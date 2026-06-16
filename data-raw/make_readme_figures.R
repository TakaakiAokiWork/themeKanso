# README 用ギャラリ画像を生成するスクリプト。
# 実行: Rscript data-raw/make_readme_figures.R   (要 ggsci)
# 出力先: man/figures/
# 過去の論文図のプロット種に倣う。離散は ggsci の AAAS、連続は viridis を使う。

suppressPackageStartupMessages(library(tidyverse))
library(ggsci)
library(patchwork)
library(sf)
library(themeKanso)

dir.create("man/figures", showWarnings = FALSE, recursive = TRUE)

save_fig <- function(name, plot, width = 5, height = 3.2) {
  ggsave(file.path("man/figures", name), plot,
         width = width, height = height, dpi = 120)
}

# Scatter（iris）
p_scatter <- ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_aaas() +
  labs(title = "Scatter",
       x = "Sepal length", y = "Petal length", colour = "Species") +
  theme_kanso()
save_fig("scatter.png", p_scatter)

# Histogram（diamonds）
p_hist <- ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(bins = 50) +
  scale_fill_aaas() +
  labs(title = "Histogram", x = "Price", y = "Count", fill = "Cut") +
  theme_kanso()
save_fig("histogram.png", p_hist)

# Line / time series（txhousing）
cities <- c("Houston", "Dallas", "Austin", "San Antonio")
df_line <- txhousing |>
  filter(city %in% cities) |>
  drop_na(sales)
p_line <- ggplot(df_line, aes(date, sales, colour = city)) +
  geom_line(linewidth = 0.8) +
  scale_color_aaas() +
  labs(title = "Line", x = "Year", y = "Home sales", colour = "City") +
  theme_kanso()
save_fig("line.png", p_line)

# Heatmap（faithfuld、連続 fill は viridis）
p_heat <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() +
  scale_fill_viridis_c(option = "plasma") +
  labs(title = "Heatmap", x = "Waiting", y = "Eruptions", fill = "Density") +
  theme_kanso()
save_fig("heatmap.png", p_heat)

# Bar（mpg）
p_bar <- ggplot(mpg, aes(class, fill = drv)) +
  geom_bar() +
  scale_fill_aaas() +
  labs(title = "Bar", x = "Class", y = "Count", fill = "Drive") +
  theme_kanso() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))
save_fig("bar.png", p_bar)

# Boxplot（mpg）
p_box <- ggplot(mpg, aes(drv, hwy, fill = drv)) +
  geom_boxplot() +
  scale_fill_aaas() +
  labs(title = "Boxplot", x = "Drive", y = "Highway MPG", fill = "Drive") +
  theme_kanso()
save_fig("boxplot.png", p_box)

# Facet（mpg）
p_facet <- ggplot(mpg, aes(displ, hwy, colour = drv)) +
  geom_point() +
  facet_wrap(~ drv) +
  scale_color_aaas() +
  labs(title = "Facet", x = "Displacement", y = "Highway MPG", colour = "Drive") +
  theme_kanso()
save_fig("facet.png", p_facet)

# Map（sf 同梱の North Carolina、連続 fill は viridis）
nc <- st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
p_map <- ggplot(nc) +
  geom_sf(aes(fill = SID74), colour = "white", linewidth = 0.1) +
  scale_fill_viridis_c(option = "viridis") +
  labs(title = "Map", fill = "SID 74") +
  theme_kanso_map()
save_fig("map.png", p_map)

# patchwork で3図を横並び（A4 本文幅 ≈ 16cm 想定）
# plot_annotation(tag_levels = "A") でパネルラベルが付き、theme_kanso() で太字・左上になる。
row <- (p_scatter + p_box + p_line) +
  plot_layout(ncol = 3) +
  plot_annotation(tag_levels = "A") &
  theme(legend.position = "none")
ggsave("man/figures/patchwork_row.png", row,
       width = 16, height = 5.5, units = "cm", dpi = 150)

cat("man/figures/ に9枚の画像を出力しました\n")
