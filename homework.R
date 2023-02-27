---
  title: "Differences Between Serbian and Croatian Pop Music"
output: 
  flexdashboard::flex_dashboard:
  storyboard: true
---
  
  
  Observable Differences {.storyboard}
=========================================
  
  ### Frame 1
  
  ```
{r} 

serbian_pop <- spotifyr::get_playlist_audio_features("", "0KsWyEIsJpyZtP1PgQVvOD")
croatian_pop <- spotifyr::get_playlist_audio_features("", "1iqFmUPFuPpBVgvrWccMVW")

balkan_pop <-
  bind_rows(
    serbian_pop |> mutate(category = "Serbian Pop"),
    croatian_pop |> mutate(category = "Croatian Pop")
  )

balkan_pop |>                    # Start with awards.
  mutate(
    mode = ifelse(mode == 0, "Minor", "Major")
  ) |>
  ggplot(                     # Set up the plot.
    aes(
      x = valence,
      y = energy,
      size = loudness,
      colour = mode
    )
  ) +
  geom_point() +              # Scatter plot.
  geom_rug(linewidth = 0.1) + # Add 'fringes' to show data distribution.
  geom_text(                  # Add text labels from above.
    aes(
      x = valence,
      y = energy,
      label = label
    ),
    data = 
      tibble(
        label = c("more clustered", "more dispersed"),
        category = c("Serbian Pop", "Croatian Pop"),
        valence = c(0.090, 0.123),
        energy = c(0.101, 0.967)
      ),
    colour = "black",         # Override colour (not mode here).
    size = 3,                 # Override size (not loudness here).
    hjust = "left",           # Align left side of label with the point.
    vjust = "bottom",         # Align bottom of label with the point.
    nudge_x = -0.05,          # Nudge the label slightly left.
    nudge_y = 0.02            # Nudge the label slightly up.
  ) +
  facet_wrap(~ category) +    # Separate charts per playlist.
  scale_x_continuous(         # Fine-tune the x axis.
    limits = c(0, 1),
    breaks = c(0, 0.50, 1),   # Use grid-lines for quadrants only.
    minor_breaks = NULL       # Remove 'minor' grid-lines.
  ) +
  scale_y_continuous(         # Fine-tune the y axis in the same way.
    limits = c(0, 1),
    breaks = c(0, 0.50, 1),
    minor_breaks = NULL
  ) +
  scale_colour_brewer(        # Use the Color Brewer to choose a palette.
    type = "qual",            # Qualitative set.
    palette = "Paired"        # Name of the palette is 'Paired'.
  ) +
  scale_size_continuous(      # Fine-tune the sizes of each point.
    trans = "exp",            # Use an exp transformation to emphasise loud.
    guide = "none"            # Remove the legend for size.
  ) +
  theme_light() +             # Use a simpler theme.
  labs(                       # Make the titles nice.
    x = "Valence",
    y = "Energy",
    colour = "Mode"
  )
```
Chromograms of Representative Songs {.storyboard}
=========================================
  
  ### Frame 2
  
  ```{r} 

hanuma <-
  get_tidy_audio_analysis("6MdJxslHXQkcLm2swuZrFb") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

hanuma |>
  mutate(pitches = map(pitches, compmus_normalise, "euclidean")) |>
  compmus_gather_chroma() |> 
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


```{r} 
dani_su_bez_broja <-
  get_tidy_audio_analysis("441S5TX0FNPrRvVc4OZidx") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

dani_su_bez_broja |>
  mutate(pitches = map(pitches, compmus_normalise, "euclidean")) |>
  compmus_gather_chroma() |> 
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

***
  
  These two chromograms showcase representative songs
for each corpus. As observed, the song Hanuma
showcases harmonic emphasis of the tonic and the fifth, 
while the song Dani su bez broja apprear to have a more homogeneous 
distribution of pitch, 
with a steady employment of the base note. 


