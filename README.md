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
4. Trigger a build on Travis (top-right corner, “More Options” – “Trigger Build”).
   The (multiple) stages that install GHCJS and dependencies will only run when
   you trigger a build this way, but not on a normal push. This way, normal
   pushes are built much faster, as they do not have to go through all the
   cache-warming steps.
5. Wait.

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

  * Why do I have to trigger the push manually?

    The initial bootstrapping takes a lot of time, and needs to be split into
    multiple stages to fit into Travis time constraints. If we would run these
    stages on every step, every build would be pretty slow – even if the stages
    don’t actually do anything, just installing the apt packages and loading
    the cache takes many minutes for each stage.

    We avoid this by running these stages *only* you determine that you need
    them.

  * What is this http://hackage-ghcjs-overlay.nomeata.de/ hackage source?

    Some important GHCJS-related packages are not (yet) on hackage. Until that is
    the case, I uploaded them to an overlay repository.

  * Is the example program in this repository a good example of idiomatic
    `ghcjs-dom` use?

    No, surely not. I crudely forward-ported this demo that I wrote in 2015. If
    anyone wants to rewrite the `Main.hs` in this repository to follow best
    practices, that’d be amazing!

  * Can I use my own domain name?

    Yes. See
    <https://help.github.com/articles/using-a-custom-domain-with-github-pages/>
    and set the domain name in the `fqdn` field in `.travis.yaml`.

  * I changed something in `.travis.yaml`, but it does not seem to have an
    effect?

    You might have to [clear the Travis cache](https://docs.travis-ci.com/user/caching/#Clearing-Caches).

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


