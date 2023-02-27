remotes::install_github('jaburgoyne/compmus')

library(tidyverse)
library(spotifyr)
library(compmus)
library(dplyr)


Sys.setenv(SPOTIFY_CLIENT_ID = 'c32483b3f6df4169bce019ed93eb6f20')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '38bc731e5fa14986a61bfd9c5c8fd582')

access_token <- get_spotify_access_token()


serbian_pop <- get_playlist_audio_features("", "0KsWyEIsJpyZtP1PgQVvOD")
croatian_pop <- get_playlist_audio_features("", "1iqFmUPFuPpBVgvrWccMVW")

balkan_pop <-
  dplyr::bind_rows(
    serbian_pop |> dplyr::mutate(category = "Serbian Pop"),
    croatian_pop |> dplyr::mutate(category = "Croatian Pop")
  )


---
  title: "Differences Between Serbian and Croatian Pop Music"
output: 
  flexdashboard::flex_dashboard:
  vertical_layout: scroll
---
  
Observing Serbian and Croation Pop Music
==========================================================
  ### Chart 1
  
  ```{r}
```
Chromograms of Representative Songs
==========================================================

  ### Chart 2

```{r} 

hanuma <-
  get_tidy_audio_analysis("6MdJxslHXQkcLm2swuZrFb") |>
  dplyr::select(segments) |>
  tidyr::unnest(segments) |>
  dplyr::select(start, duration, pitches)

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
Discussing Differences
==========================================================
### Chart 3

```{r}
```

