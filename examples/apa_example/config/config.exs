use Mix.Config

# Configures the apa scale defaults
# scale < 0 (default -1) - no touch on decimal point
# scale == 0 - always integer
# scale > 0 - always make a decimal point at scale
# you can overwrite the defaults with the  following or ues explicit scale
config :apa,
  scale_default: -1
