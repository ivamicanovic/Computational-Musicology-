---
  title: "Differences Between Serbian and Croatian Pop Music"
output: 
  flexdashboard::flex_dashboard:
vertical_layout: scroll
---
  
  ```{r setup, include=FALSE}
library(flexdashboard)
```

Observing Serbian and Croation Pop Music {data-width=650}
-----------------------------------------------------------------------
  
  ### Chart A
  
  Hi I write stuff about music

```{r}

```

Chromograms of Representative Songs {data-width=350}
-----------------------------------------------------------------------
  
  ### Chart B
  
  ```{r}

library(tidyverse)
library(spotifyr)
library(compmus)
hanuma <-
  get_tidy_audio_analysis("6MdJxslHXQkcLm2swuZrFb") |>
  dplyr::select(segments) |>
  tidyr::unnest(segments) |>
  dplyr::select(start, duration, pitches)
library(ggplot2)
library(purrr)
hanuma |>
  dplyr::mutate(pitches = map(pitches, compmus_normalise, "euclidean")) |>
  compmus::compmus_gather_chroma() |> 
  ggplot(
    aes(
      x = start + duration / 2,
      width = duration,
      y = pitch_class,
      fill = value
    )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal() +
  scale_fill_viridis_c()

dani_su_bez_broja <-
  get_tidy_audio_analysis("441S5TX0FNPrRvVc4OZidx") |>
  dplyr::select(segments) |>
  tidyr::unnest(segments) |>
  dplyr::select(start, duration, pitches)

dani_su_bez_broja |>
  dplyr::mutate(pitches = map(pitches, compmus_normalise, "euclidean")) |>
  compmus::compmus_gather_chroma() |> 
  ggplot(
    aes(
      x = start + duration / 2,
      width = duration,
      y = pitch_class,
      fill = value
    )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal() +
  scale_fill_viridis_c()


```
Discussing Differences {data-width=350}
-----------------------------------------------------------------------

### Chart C

```{r}

```