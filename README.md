Deploy GHCJS applications to GitHub pages
=========================================

This repository demonstrates how to very simply deploy GHCJS-based applications to
GitHubPages, using Travis CI.

HOWTO
-----

1. Clone this repository, or drop its `.travis.yml` file into an existing
   repository.
2. Create a “Personal access tokens” on <https://github.com/settings/tokens>.
   Make sure it has the “repo“ permission.
3. Go to the settings page of your repository on Travis
   (e.g. <https://travis-ci.org/nomeata/ghcjs2gh-pages/settings>). Enable
   Travis, if not done yet. Under “Environment Variables”, store the personal
   access token from above, with name `GITHUB_TOKEN`.
4. Push and wait.

If everything works, you will be using your GHCJS program on the Github Page
URL for this project, e.g. <http://nomeata.github.io/ghcjs2gh-pages>.

As a bonus, the haddocks of the project will be on
<http://nomeata.github.io/ghcjs2gh-pages/doc>.


FAQ
---

  * Why are you not using Stack or Nix?

    This setup uses plain Cabal (no stack, no nix), not because Stack or Nix
    are bad tool, but to make this accessible to as many developers as
    possible. But ideally, it should not matter what happens on Travis.

  * Why so many stages? This makes the build very slow!

    The initial bootstrapping needs to be split into multiple stages to fit
    into Travis time constraints. But improvements are welcome!

  * What is this `ghcjs-base` stage for?

    `ghcjs-base` is no longer shipped as a boot library by GHCJS, but it is
    also not on Hackage. Until this is fixed, I tried this soluison.

    [not on Hackage]: https://github.com/ghcjs/ghcjs-base/issues/81

  * Is the example program in this repository a good example of idiomatic
    `ghcjs-dom` use?

    No, surely not. I crudely forward-ported this demo that I wrote in 2015. If
    anyone wants to rewrite the `Main.hs` in this repository to follow best
    practices, that’d be amazing!

  * Can I use my own domain name?

    Yes. See
    <https://help.github.com/articles/using-a-custom-domain-with-github-pages/>
    and set the domain name in the `fqdn` field in `.travis.yaml`.

  * Anyways, what’s the deal?

    GHCJS is tricky to build, in particular in Travis (limited build time, old
    version of things like `gcc` and `tar`). There are some crude hacks to work
    around this.

  * Why `--constraint="primitive < 0.6.4.0`?

    Becuase of this bug: https://github.com/ghcjs/ghcjs/issues/665

Possible improvements (patches welcome!)
----------------------------------------

 * Document here how to do local development without GHCJS.

 * Find out and document how to handle data files that need to be available to
   the program, and/or data files that need to be available to the browser, in
   a way that works both locally (with GHC) and remotely (with GHCJS).

 * Fix the specific version of `ghcjs`, for reproducibility.
   Unfortunately, <http://ghcjs.luite.com/> does not provide snapshorts for the
   8.2 branch.

 * Clean up `Main.hs` (see question above).

 * Also build the program using regular GHC on travis, to see if that works.

 * Build the test suite, if present, and only deploy if it passes.

 * Convince the GHCJS maintainers to make a proper release, and then convince
   @hvr to put GHCJS on <https://launchpad.net/~hvr/+archive/ubuntu/ghc> and
   get rid of most of stuff in this file.

Contact
-------

Please reports bugs and missing features at the [GitHub bugtracker]. This is
also where you can find the [source code].

`ghcjs2gh-pages` was written by [Joachim Breitner] and is licensed under a
permissive MIT [license].

[GitHub bugtracker]: https://github.com/nomeata/ghcjs2gh-pages/issues
[source code]: https://github.com/nomeata/ghcjs2gh-pages
[Joachim Breitner]: http://www.joachim-breitner.de/
[license]: https://github.com/nomeata/ghcjs2gh-pages/blob/LICENSE


