# hypercore-nixos

In order to get `hyperspace-cli`, with Nix, use this `nix shell` command:

`nix shell github:nixos/nixpkgs/8b1ff65#hyperspace-cli`

The hash `8b1ff65` comes from this pull request, where the `hyperspace-cli` was
merged. https://github.com/NixOS/nixpkgs/pull/130063

# Example Usage

1. Make a Hyperdrive:

   `hyp create drive`

2. Mirror all of the NARs from cache.nixos.org to your new Hyperdrive url via
   the `mirror.sh` script:

   `./mirror.sh hyper://<your-hyperdrive-identifier>`

3. See that your Hyperdrive is now populated with NARs, which anyone in the
   world can now download and mirror via the `hyp` cli. **Anyone in the world
   can run this command and see the same results as you**:

   `hyp ls hyper://<your-hyperdrive-identifier>/nar`

   ###### Example Output

   ```
   user: matthew hypercore-nixos on  main 
   ❯ hyp ls hyper://acc6dea56bca988267502d7d6892a27c1dc209fd3824f8305077d7d3ad52566b/nar
   0s8qgcw024wvgrah5dzz5ca9ngkwjbir244wxy60i89pjy326r4a.nar.xz
   0cmvjpqdp61gfq3xddcsliprykpg62ybjbq7cvw473bx5xl7nd2c.nar.xz
   1hbdf4x6magyf1iibrq7wfb3ai7v1az20ynfyba6z3pljq2paxyk.nar.xz
   1vd218wpqwi94m753cjszjrszvai1ip69ji1k7fg9wh1vlikjcs1.nar.xz
   1qmxmgfxnv53v2hhab6a9igah5k79mwwix4ar9nx2ih0nxgk8izj.nar.xz
   1ai6sa578wiki7qgjidl1vp34105ljp0lxvxh0i22rmlzfbkqqgk.nar.xz
   ```

# Basic Idea

This distributes the NixOS binary cache via a Hyperdrive, which is a data
structure on top of Hypercore. Users who want to help others to mirror popular
signed NARs from cache.nixos.org can do so via this method.

The NAR binary archives are not unpacked or rebuilt, they are unmodified,
preserving hash integrity. They can be checked for authenticity via the
`.narinfo` file supplied by cache.nixos.org.

# Tooling

The Nix builder, must understand `hyper://`, or this can be redistributed via
`http://`:

- `http://localhost:8080/nar/zzzbs5nj3wr59phi0ck9w5f2mnfhzdcj-a-nixos-package-2.18.4`
- `hyper://1234../nar/zzzbs5nj3wr59phi0ck9w5f2mnfhzdcj-a-nixos-package-2.18.4` 

# Notes

To mirror a complete NixOS package set is quite a task, however, a minimal set
of NARs such as nixos-minimal can be used for testing.

