let
  module = fetchTarball {
    name = "source";
    url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
    sha256 = "sha256-yEO2cGNgzm9x/XxiDQI+WckSWnZX63R8aJLBRSXtYNE=";
  };
  lixSrc = fetchTarball {
    name = "source";
    url = "https://git.lix.systems/lix-project/lix/archive/2.90.0.tar.gz";
    sha256 = "sha256-f8k+BezKdJfmE+k7zgBJiohtS3VkkriycdXYsKOm3sc=";
  };
  # This is the core of the code you need; it is an exercise to the
  # reader to write the sources in a nicer way, or by using npins or
  # similar pinning tools.
in
import "${module}/module.nix" { lix = lixSrc; }
