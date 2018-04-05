min_tire_psi <- 15
max_tire_psi <- 120

min_rider_weight <- 80
max_rider_weight <- 250
max_load_weight <- 50

# Data from DT Swiss
max_rim_psi <- tibble::tribble(
  ~tire_width_mm, ~max_rim_psi,
  #-------------/----------/
  20, 138,
  23, 131,
  25, 123,
  28, 113,
  30, 104,
  32, 99,
  35, 87,
  37, 83,
  40, 80,
  42, 75,
  44, 73,
  47, 68,
  50, 64,
  52, 59,
  54, 55
)
