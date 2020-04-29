use Mix.Config

# Configures the apa precision and scale defaults
# scale < 0 (default -1) - no touch on decimal point
# scale == 0 - always integer
# scale > 0 - always make a decimal point at scale
# precision <= 0 - (default -1) - no touch at the precision == arbitrary precision
# precision > 0 - the total count of significant digits in the whole number
# you can overwrite the defaults with the  following or ues explicit precision and/or scale
config :apa,
  precision_default: -1,
  scale_default: -1
