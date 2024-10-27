# This includes the Lix NixOS module in your configuration along with the
# matching version of Lix itself.
#
# The sha256 hashes were obtained with the following command in Lix (n.b.
# this relies on --unpack, which is only in Lix and CppNix > 2.18):
# nix store prefetch-file --name source --unpack https://git.lix.systems/lix-project/lix/archive/2.91.1.tar.gz
#
# Note that the tag (e.g. 2.91.1) in the URL here is what determines
# which version of Lix you'll wind up with.
let
  module = fetchTarball {
    name = "source";
    url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
    sha256 = "sha256-6U0CyPycIBc04hbYy2hBINnVso58n/ZyywY2BD3hu+s=";
  };
  lixSrc = fetchTarball {
    name = "source";
    url = "https://git.lix.systems/lix-project/lix/archive/2.91.1.tar.gz";
    sha256 = "sha256-hiGtfzxFkDc9TSYsb96Whg0vnqBVV7CUxyscZNhed0U=";
  };
in
# This is the core of the code you need; it is an exercise to the
# reader to write the sources in a nicer way, or by using npins or
# similar pinning tools.
import "${module}/module.nix" { lix = lixSrc; }
