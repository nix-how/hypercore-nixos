#! /usr/bin/env nix-shell
#! nix-shell -i bash -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/8b1ff65.tar.gz -p hyperspace-cli jq

# Mirror all the NARs connected to a Nix channel into a Hyperdrive and then share it on localhost:8080

hyperurl="$1"

bash -c "hyp drive mkdir $hyperurl/nar "

wget https://channels.nixos.org/nixos-21.05/store-paths.xz
xz -d store-paths.xz

while read -r line
        do GET=`nix path-info --store https://cache.nixos.org --json $line | jq -r .[].url;` 
        echo HI $GET
        OUTPUT=`basename $GET`
        echo BASENAME= $OUTPUT

        wget --directory-prefix=nar/ https://cache.nixos.org/$GET
	cd nar
        echo "RUNNING hyp drive put $hyperurl/nar < $OUTPUT"
	bash -c "hyp drive put $hyperurl/nar/$OUTPUT < $OUTPUT"
	cd ..
        echo "RETURNED"
done < "store-paths"
